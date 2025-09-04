local o = vim.opt

-- stylua: ignore
local options = {
  -- Clipboard / yank/paste
  clipboard = "unnamedplus",        -- use system clipboard for all yank/paste

  -- Editing behavior
  expandtab = true,                 -- convert tabs to spaces
  shiftwidth = 2,                   -- spaces per indent
  tabstop = 2,                      -- spaces that a <Tab> counts for
  smartindent = true,               -- smarter auto-indenting
  formatoptions = "jcroqlnt",       -- text formatting behavior
  virtualedit = "block",            -- allow cursor past EOL in visual block mode

  -- Search behavior
  ignorecase = true,                -- case-insensitive search...
  smartcase = true,                 -- ...but make search case-sensitive if caps used

  -- Appearance / UI
  cursorline = true,                -- highlight the current line
  number = true,                    -- show line numbers
  relativenumber = true,            -- relative line numbers
  numberwidth = 3,                  -- minimal width for line numbers
  laststatus = 3,                   -- global statusline
  signcolumn = "yes",               -- always show sign column
  showmode = false,                 -- don’t show --INSERT-- etc
  scrolloff = 4,                    -- keep cursor away from top/bottom edge
  termguicolors = true,             -- truecolor support

  -- Mouse / interaction
  mouse = "a",                      -- enable mouse support
  confirm = true,                   -- ask for confirmation instead of erroring

  -- Split / window behavior
  splitbelow = true,                -- horizontal splits go below
  splitright = true,                -- vertical splits go to the right
  splitkeep = "screen",             -- keep text stable when splitting

  -- Shell / commands
  shell = "/opt/homebrew/bin/fish", -- use fish shell
  shellcmdflag = "-c",              -- shell command flag
}

for key, value in pairs(options) do
  o[key] = value
end
