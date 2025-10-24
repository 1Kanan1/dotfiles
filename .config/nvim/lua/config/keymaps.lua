-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local wk = require("which-key")

-- stylua: ignore
wk.add({
  -- notifications
  { "<leader>n", desc = "noice/notifications", icon = { icon = "󰈸", color = "orange" } },
  { "<leader>ns", function() Snacks.picker.notifications() end, desc = "Show Notifications", icon = { icon = "󰈸", color = "orange" } },
  { "<leader>nh", function() Snacks.notifier.show_history() end, desc = "Notification History", icon = "" },
  { "<leader>nd", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications", icon = "󰎟" },
})
