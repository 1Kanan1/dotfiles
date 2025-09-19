-- TODO: add prettier_d support
-- kill daemon after closing neovim
---@diagnostic disable-next-line: missing-fields
vim.api.nvim_create_autocmd("VimLeave", {
  callback = function()
    local handle
    handle = vim.uv.spawn("eslint_d", { args = { "stop" } }, function()
      if handle then
        handle:close()
      end
    end)
  end,
})
