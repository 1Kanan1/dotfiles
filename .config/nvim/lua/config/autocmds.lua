-- kill processes after closing neovim
---@diagnostic disable-next-line: missing-fields
vim.api.nvim_create_autocmd("VimLeave", {
  callback = function()
    local paths = { "prettierd" }

    for _, cmd in ipairs(paths) do
      local handle
      handle = vim.uv.spawn(cmd, { args = { "stop" } }, function()
        if handle then
          handle:close()
        end
      end)
    end
  end,
})
-- File synchronization - automatically reload files when changed externally
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
  pattern = { "*" },
  callback = function()
    if vim.o.autoread then
      vim.cmd("checktime")
    end
  end,
})

-- Also set up file change notifications
vim.api.nvim_create_autocmd("FileChangedShellPost", {
  pattern = { "*" },
  command = "echo 'File changed on disk. Buffer reloaded.'",
})
