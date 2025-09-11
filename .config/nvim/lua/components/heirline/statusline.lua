local M = {}

local conditions = require("heirline.conditions")
local utils = require("heirline.utils")
local env = require("components.heirline.env")
local picker = require("snacks.picker")
local signs = vim.diagnostic.config().signs.text or {}

-- MODE -----------------------------------------------------------------------

M.Mode = {
  init = function(self)
    self.mode = vim.fn.mode(1)
  end,
  static = {
    mode_colors = {
      n = "blue",
      i = "green",
      v = "purple",
      V = "purple",
      ["\22"] = "cyan",
      c = "orange",
      s = "purple",
      S = "purple",
      ["\19"] = "purple",
      R = "orange",
      r = "orange",
      ["!"] = "red",
      t = "red",
    },
  },
  provider = " ",
  hl = function(self)
    local mode = self.mode:sub(1, 1)
    return { bg = self.mode_colors[mode], bold = true }
  end,
  update = {
    "ModeChanged",
    pattern = "*:*",
    callback = vim.schedule_wrap(function()
      vim.cmd("redrawstatus")
    end),
  },
}

-- GIT ------------------------------------------------------------------------

M.Git = {
  condition = conditions.is_git_repo,
  init = function(self)
    self.status_dict = vim.b.gitsigns_status_dict
    self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
  end,
}

M.GitBranch = utils.insert(M.Git, env.Space(2), {
  provider = function(self)
    local branch = self.status_dict.head
    local max_len = 15
    return " " .. (#branch < max_len and branch or branch:sub(1, max_len - 1) .. "…")
  end,
  hl = { fg = "orange", bold = true, bg = utils.get_highlight("Normal").bg },
  on_click = {
    callback = function()
      picker.git_branches()
    end,
    name = "heirline_git_branches",
  },
})

M.GitStatus = utils.insert(M.Git, {
  on_click = {
    callback = function()
      picker.git_status({ cwd = vim.fs.root(0, ".git") })
    end,
    name = "heirline_git_status",
  },
  env.Space(2),
  {
    provider = function(self)
      local count = self.status_dict.added or 0
      return count > 0 and (" " .. count .. " ")
    end,
    hl = { fg = "git_add" },
  },
  {
    provider = function(self)
      local count = self.status_dict.removed or 0
      return count > 0 and (" " .. count .. " ")
    end,
    hl = { fg = "git_del" },
  },
  {
    provider = function(self)
      local count = self.status_dict.changed or 0
      return count > 0 and (" " .. count .. " ")
    end,
    hl = { fg = "git_change" },
  },
  hl = { bg = utils.get_highlight("Normal").bg },
})

-- FILENAME ------------------------------------------------------------------

M.FileNameBlock = {
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(0)
  end,
  hl = { bg = utils.get_highlight("Normal").bg },
}

local Folder = {
  init = function(self)
    local root = vim.fs.root(0, { ".git", "package.json", "pyproject.toml", "Cargo.toml", "go.mod" })
    local cwd = vim.fn.getcwd()

    if root then
      -- checks if root is a subdir of cwd and returns cwd; otherwise, root
      self.fdname = (cwd:find(root, 1, true) == 1 and cwd or root):match("([^/]+)$")
    else
      self.fdname = cwd:match("([^/]+)$")
    end

    local icon, color
    local ok, MiniIcons = pcall(require, "mini.icons")
    if ok then
      local hl
      icon, hl = MiniIcons.get("directory", self.fdname)
      if icon then
        color = hl and vim.api.nvim_get_hl(0, { name = hl }).fg or nil
      end
    end
    self.icon = icon or nil
    self.icon_color = color or nil
  end,

  provider = function(self)
    return self.icon and (self.icon .. " " .. self.fdname)
  end,

  hl = function(self)
    return { fg = self.icon_color }
  end,

  env.Space(2),
}

local FileName = {
  init = function(self)
    if self.filename:match("^term://.*/+%d+:") then
      self.lfilename = self.filename:gsub("^term://.*/+(%d+):.*$", "term:%1")
    else
      local path = vim.fn.fnamemodify(self.filename, ":.")
      local parts = {}
      for part in path:gmatch("[^/]+") do
        table.insert(parts, part)
      end

      if #parts > 3 then
        -- Keep first folder, add "...", keep last two (second-to-last folder + filename)
        local short_parts = { parts[1], "…", parts[#parts - 1], parts[#parts] }
        self.lfilename = table.concat(short_parts, "/")
      else
        self.lfilename = path
      end
    end

    if self.lfilename == "" then
      self.lfilename = vim.bo.filetype ~= "" and vim.bo.filetype or "[No Name]"
    end
  end,
  hl = { fg = utils.get_highlight("Directory").fg },
  flexible = 2,
  {
    provider = function(self)
      return self.lfilename
    end,
  },
}

local FileFlags = {
  env.Space(1),
  {
    condition = function()
      return vim.bo.modified
    end,
    provider = "",
    hl = { fg = "white" },
  },
  {
    condition = function()
      return not vim.bo.modifiable or vim.bo.readonly
    end,
    provider = "",
    hl = { fg = "orange" },
  },
}

M.FileType = utils.insert(M.FileNameBlock, env.Space(2), Folder, env.FileIcon, FileName, FileFlags)

-- LSP ------------------------------------------------------------------------

M.LSPActive = {
  condition = conditions.lsp_attached,
  update = { "LspAttach", "LspDetach" },
  provider = function()
    local clients = {}
    for _, server in pairs(vim.lsp.get_clients()) do
      table.insert(clients, server.name)
    end

    return "  " .. clients[1] .. (#clients > 1 and ", +" .. #clients - 1 or "")
  end,
  hl = { fg = "bright_fg", bg = utils.get_highlight("Normal").bg },
  on_click = {
    callback = function()
      vim.cmd("LspInfo")
    end,
    name = "heirline_lsp_info",
  },
  env.Space(2),
}

-- DIAGNOSTICS ----------------------------------------------------------------

M.Diagnostics = {
  env.Space(2),
  condition = conditions.has_diagnostics,
  static = {
    error_icon = signs[vim.diagnostic.severity.ERROR],
    warn_icon = signs[vim.diagnostic.severity.WARN],
    info_icon = signs[vim.diagnostic.severity.INFO],
    hint_icon = signs[vim.diagnostic.severity.HINT],
  },
  init = function(self)
    self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
  end,
  on_click = {
    callback = function()
      picker.diagnostics()
    end,
    name = "heirline_diagnostics",
  },
  update = { "DiagnosticChanged", "BufEnter" },
  {
    provider = function(self)
      return self.errors > 0 and (self.error_icon .. " " .. self.errors .. " ")
    end,
    hl = { fg = "diag_error" },
  },
  {
    provider = function(self)
      return self.warnings > 0 and (self.warn_icon .. " " .. self.warnings .. " ")
    end,
    hl = { fg = "diag_warn" },
  },
  {
    provider = function(self)
      return self.info > 0 and (self.info_icon .. " " .. self.info .. " ")
    end,
    hl = { fg = "diag_info" },
  },
  {
    provider = function(self)
      return self.hints > 0 and (self.hint_icon .. " " .. self.hints)
    end,
    hl = { fg = "diag_hint" },
  },
  hl = { bg = utils.get_highlight("Normal").bg },
}

-- RULER ----------------------------------------------------------------------

M.Ruler = {
  provider = "%l:%L %P",
  hl = { bg = utils.get_highlight("Normal").bg },
  env.Space(2),
}

-- STATUSLINE ASSEMBLY -------------------------------------------------------

M.StatusLine = {
  condition = function()
    return vim.bo.filetype ~= "dashboard"
  end,
  hl = "None",
}

M.StatusLine = utils.insert(
  M.StatusLine,
  M.Mode,
  M.GitBranch,
  M.FileType,
  M.GitStatus,
  M.Diagnostics,
  env.Align,
  M.LSPActive,
  M.Ruler,
  M.Mode
)

return M
