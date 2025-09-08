local M = {}
local utils = require("heirline.utils")

M.Align = { provider = "%=", hl = { bg = utils.get_highlight("Normal").bg } }

M.Space = function(n)
  return { provider = string.rep(" ", n or 1), hl = { bg = utils.get_highlight("Normal").bg } }
end

M.FileIcon = {
  init = function(self)
    local ext = vim.fn.fnamemodify(self.filename, ":e")
    ext = ext ~= "" and ext or vim.fn.fnamemodify(self.filename, ":t")
    self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(self.filename, ext, { default = true })
  end,
  provider = function(self)
    return self.icon and (self.icon .. " ")
  end,
  hl = function(self)
    if self.bufnr and not (self.is_active or self.is_visible) then
      return { bg = utils.get_highlight("Normal").bg }
    end
    return { fg = self.icon_color, bg = utils.get_highlight("Normal").bg }
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
    git_del     = get("diffRemoved").fg,        -- onedark: git("diffDeleted").fg
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
