local M = {}

local conditions = require("heirline.conditions")
local utils = require("heirline.utils")
local env = require("components.heirline.env")
local picker = require("snacks.picker")

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
    return " " .. self.status_dict.head
  end,
  hl = { fg = "orange", bold = true },
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
      picker.git_status()
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
})

-- FILENAME ------------------------------------------------------------------

M.FileNameBlock = {
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(0)
  end,
}

local FileName = {
  init = function(self)
    if self.filename:match("^term://.*/+%d+:") then
      self.lfilename = self.filename:gsub("^term://.*/+(%d+):.*$", "term:%1")
    else
      self.lfilename = vim.fn.fnamemodify(self.filename, ":.")
    end

    if self.lfilename == "" then
      self.lfilename = "[No Name]"
    end
  end,
  hl = { fg = utils.get_highlight("Directory").fg },
  flexible = 2,
  {
    provider = function(self)
      return self.lfilename
    end,
  },
  {
    provider = function(self)
      return vim.fn.pathshorten(self.lfilename)
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

M.FileType = utils.insert(M.FileNameBlock, env.Space(2), env.FileIcon, FileName, FileFlags)

-- LSP ------------------------------------------------------------------------

M.LSPActive = {
  condition = conditions.lsp_attached,
  update = { "LspAttach", "LspDetach" },
  provider = function()
    local names = {}
    for _, server in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
      table.insert(names, server.name)
    end
    return "  " .. table.concat(names, ", ")
  end,
  hl = { fg = "bright_fg" },
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
    error_icon = vim.fn.sign_getdefined("DiagnosticSignError")[1].text,
    warn_icon = vim.fn.sign_getdefined("DiagnosticSignWarn")[1].text,
    info_icon = vim.fn.sign_getdefined("DiagnosticSignInfo")[1].text,
    hint_icon = vim.fn.sign_getdefined("DiagnosticSignHint")[1].text,
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
      return self.errors > 0 and (self.error_icon .. self.errors .. " ")
    end,
    hl = { fg = "diag_error" },
  },
  {
    provider = function(self)
      return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
    end,
    hl = { fg = "diag_warn" },
  },
  {
    provider = function(self)
      return self.info > 0 and (self.info_icon .. self.info .. " ")
    end,
    hl = { fg = "diag_info" },
  },
  {
    provider = function(self)
      return self.hints > 0 and (self.hint_icon .. self.hints)
    end,
    hl = { fg = "diag_hint" },
  },
}

-- RULER ----------------------------------------------------------------------

M.Ruler = {
  provider = "%l:%L %P",
  hl = { bg = "None" },
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
