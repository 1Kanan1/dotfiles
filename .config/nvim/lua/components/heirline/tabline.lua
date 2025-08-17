local M = {}
local env = require("components.heirline.env")
local utils = require("heirline.utils")

-- Tabline filename with fallback
M.TablineFileName = {
  provider = function(self)
    local filename = self.filename
    if filename == "" then
      return "[No Name]"
    end
    return vim.fn.fnamemodify(filename, ":.:h:t") .. "/" .. vim.fn.fnamemodify(filename, ":t")
  end,
  hl = function(self)
    return { fg = "darkgray", bold = self.is_active or self.is_visible }
  end,
}

-- File flags (modified, readonly)
M.TablineFileFlags = {
  {
    condition = function(self)
      return vim.api.nvim_get_option_value("modified", { buf = self.bufnr })
    end,
    provider = "",
    hl = { fg = "white" },
    env.Space(1),
  },
  {
    condition = function(self)
      return not vim.api.nvim_get_option_value("modifiable", { buf = self.bufnr })
        or vim.api.nvim_get_option_value("readonly", { buf = self.bufnr })
    end,
    provider = function(self)
      return vim.bo[self.bufnr].buftype ~= "terminal" and ""
    end,
    hl = { fg = "orange" },
  },
}

-- Complete file block
M.TablineFileBlock = utils.insert({
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(self.bufnr)
  end,
  on_click = {
    callback = function(_, minwid, _, button)
      if button == "m" then
        vim.schedule(function()
          vim.api.nvim_buf_delete(minwid, { force = false })
        end)
      else
        vim.api.nvim_win_set_buf(0, minwid)
      end
    end,
    minwid = function(self)
      return self.bufnr
    end,
    name = "heirline_tabline_buffer_callback",
  },
  {
    provider = function(self)
      return (self.is_active or self.is_visible) and "┃" or "│"
    end,
    hl = function(self)
      return { fg = (self.is_active or self.is_visible) and "blue" or "gray" }
    end,
  },
}, env.Space(1), env.FileIcon, M.TablineFileName, env.Space(1), M.TablineFileFlags)

-- Close button
M.TablineCloseButton = {
  condition = function(self)
    return self.filename ~= ""
  end,
  env.Space(1),
  provider = "󰅖",
  hl = function(self)
    return { fg = (self.is_active or self.is_visible) and "red" }
  end,
  on_click = {
    callback = function(_, minwid)
      vim.schedule(function()
        vim.api.nvim_buf_delete(minwid, { force = false })
        vim.cmd.redrawtabline()
      end)
    end,
    minwid = function(self)
      return self.bufnr
    end,
    name = "heirline_tabline_close_buffer_callback",
  },
}

M.TablineBufferBlock = {
  M.TablineFileBlock,
  M.TablineCloseButton,
  env.Space(1),
}

-- Cache buffer list
local buflist_cache = {}
local function get_bufs()
  return vim.tbl_filter(function(bufnr)
    return vim.api.nvim_get_option_value("buflisted", { buf = bufnr })
  end, vim.api.nvim_list_bufs())
end

vim.api.nvim_create_autocmd({ "VimEnter", "UIEnter", "BufAdd", "BufDelete" }, {
  callback = function()
    vim.schedule(function()
      local buffers = get_bufs()
      for i, v in ipairs(buffers) do
        buflist_cache[i] = v
      end
      for i = #buffers + 1, #buflist_cache do
        buflist_cache[i] = nil
      end
      if vim.bo.filetype ~= "dashboard" then
        if #buflist_cache > 1 then
          vim.o.showtabline = 2
        else
          vim.o.showtabline = 0
        end
      end
    end)
  end,
})

M.BufferLine = utils.make_buflist(
  M.TablineBufferBlock,
  { provider = " ", hl = { fg = "gray" } },
  { provider = " ", hl = { fg = "gray" } },
  function()
    return buflist_cache
  end,
  false
)

-- Neo-tree or other offset components
M.TabLineOffset = {
  condition = function(self)
    local win = vim.api.nvim_tabpage_list_wins(0)[1]
    local bufnr = vim.api.nvim_win_get_buf(win)
    self.winid = win
    local ft = vim.bo[bufnr].filetype

    if ft == "neo-tree" then
      self.title = "File Explorer"
      return true
    elseif ft == "snacks" or ft == "snacks-preview" then
      self.title = "Snacks"
      return true
    end
  end,

  provider = function(self)
    local title = self.title
    local width = vim.api.nvim_win_get_width(self.winid)
    local pad = math.ceil((width - #title) / 2)
    return string.rep(" ", pad) .. title .. string.rep(" ", pad)
  end,

  hl = { fg = "blue", bold = true },
}

M.TabLine = {
  M.TabLineOffset,
  M.BufferLine,
}

return M
