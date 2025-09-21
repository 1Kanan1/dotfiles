local M = {}
local utils = require("heirline.utils")

M.Align = { provider = "%=", hl = { bg = utils.get_highlight("Normal").bg } }

M.Space = function(n)
  return { provider = string.rep(" ", n or 1), hl = { bg = utils.get_highlight("Normal").bg } }
end

M.FileIcon = {
  init = function(self)
    local filepath = self.filename or ""
    local name = vim.fn.fnamemodify(filepath, ":t") -- basename (e.g., env.lua)
    local ext = vim.fn.fnamemodify(filepath, ":e") -- extension (e.g., lua)
    ext = ext ~= "" and ext or "file"
    local icon, color

    -- Check if this is a terminal buffer
    local is_term = vim.b.buftype == "terminal" or filepath:match("^term://")

    if is_term then
      -- Use a terminal icon
      icon = "" -- Nerd Font terminal icon
      color = utils.get_highlight("Function").fg -- optional color for terminal
    else
      -- Try mini.icons first
      local ok, MiniIcons = pcall(require, "mini.icons")
      if ok then
        local hl
        icon, hl = MiniIcons.get("file", name)
        if icon then
          color = hl and vim.api.nvim_get_hl(0, { name = hl }).fg or nil
        end
      end

      -- Fallback to nvim-web-devicons
      if not self.icon then
        local ok_dev, devicons = pcall(require, "nvim-web-devicons")
        if ok_dev then
          icon, color = devicons.get_icon_color(name, ext, { default = true })
        end
      end
    end

    -- Default fallback
    self.icon = icon or ""
    self.icon_color = color or utils.get_highlight("Normal").fg
  end,

  provider = function(self)
    return self.icon and (self.icon .. " ")
  end,

  hl = function(self)
    local bg = utils.get_highlight("Normal").bg
    if self.bufnr and not (self.is_active or self.is_visible) then
      return { bg = bg }
    end
    return { fg = self.icon_color, bg = bg }
  end,
}

-- stylua: ignore
function M.setup_colors()
  local get = utils.get_highlight
  return {
    bright_bg   = get("Folded").bg,
    bright_fg   = get("Folded").fg,
    red         = get("DiagnosticError").fg,
    dark_red    = get("DiffDelete").bg,
    green       = get("String").fg,
    blue        = get("Function").fg,
    gray        = get("NonText").fg,
    orange      = get("Number").fg,
    purple      = get("Statement").fg,
    cyan        = get("Special").fg,
    diag_warn   = get("DiagnosticWarn").fg,
    diag_error  = get("DiagnosticError").fg,
    diag_hint   = get("DiagnosticHint").fg,
    diag_info   = get("DiagnosticInfo").fg,
    git_del     = get("diffRemoved").fg,        -- onedark: get("diffDeleted").fg
    git_add     = get("diffAdded").fg,
    git_change  = get("diffChanged").fg,
  }
end

vim.api.nvim_create_augroup("Heirline", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
  group = "Heirline",
  callback = function()
    utils.on_colorscheme(M.setup_colors)
  end,
})

return M
