-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local uv = vim.uv or vim.loop

if not uv.fs_stat(lazypath) then
  local lazy_repo = "https://github.com/folke/lazy.nvim.git"
  local clone_cmd = { "git", "clone", "--filter=blob:none", "--branch=stable", lazy_repo, lazypath }
  local result = vim.fn.system(clone_cmd)

  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { result, "WarningMsg" },
      { "\nPress any key to exit...", "Normal" },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

-- Set leaders early
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Configure diagnostics
local signs = {
  [vim.diagnostic.severity.ERROR] = { icon = "", hl = "DiagnosticSignError" },
  [vim.diagnostic.severity.WARN] = { icon = "", hl = "DiagnosticSignWarn" },
  [vim.diagnostic.severity.HINT] = { icon = "", hl = "DiagnosticSignHint" },
  [vim.diagnostic.severity.INFO] = { icon = "", hl = "DiagnosticSignInfo" },
}

local signs_text, signs_hl = {}, {}
for sev, t in pairs(signs) do
  signs_text[sev] = t.icon
  signs_hl[sev] = t.hl
end

vim.diagnostic.config({
  virtual_text = true,
  signs = {
    text = signs_text,
    texthl = signs_hl,
  },
})

-- Setup lazy.nvim
require("lazy").setup({
  defaults = { lazy = true },
  spec = { { import = "plugins" } },
  install = { colorscheme = { "tokyonight" } },
  checker = { enabled = true }, -- automatic plugin update checks
  change_detection = { notify = false }, -- don't spam notifications
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
        "syntactic",
        "rplugin",
      },
    },
  },
})
