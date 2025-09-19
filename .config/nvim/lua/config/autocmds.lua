-- kill processes after closing neovim
---@diagnostic disable-next-line: missing-fields
vim.api.nvim_create_autocmd("VimLeave", {
  callback = function()
    local paths = { "eslint_d", "prettier_d" }

    for _, cmd in ipairs(paths) do
      local handle
      handle = vim.loop.spawn(cmd, { args = { "stop" } }, function()
        if handle then
          handle:close()
        end
      end)
    end
  end,
})
