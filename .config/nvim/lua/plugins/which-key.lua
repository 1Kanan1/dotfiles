return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    preset = "helix",
    plugins = { spelling = true },
    icons = {
      group = "",
    },
    mode = {
      n = true,
      v = true,
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.add({
      -- group labels
      { "]", desc = "+next" },
      { "[", desc = "+prev" },
      { "<leader>b", desc = "+buffer", icon = "" },
      { "<leader>w", desc = "+window", icon = "" },
      { "<leader>t", desc = "+terminal", icon = "" },
      { "<leader>c", desc = "+code", icon = "" },
      { "<leader>d", desc = "+debug (DAP)", icon = "" },
      { "<leader>e", desc = "File Explorer", icon = "󰝰" },
      { "<leader>f", desc = "+find/file (Telescope)" },
      { "<leader>l", "<cmd>Lazy<cr>", desc = "lazy" },
      { "<leader>m", desc = "+github", icon = "" },
      { "<leader>x", desc = "+diagnostics/quickfix" },

      -- buffer navigation
      { "[b", "<cmd>bprevious<cr>", desc = "Previous Buffer", icon = "" },
      { "]b", "<cmd>bnext<cr>", desc = "Next Buffer", icon = "" },

      -- window movement
      { "<C-h>", "<C-w>h", desc = "Go to Left Window", icon = "" },
      { "<C-j>", "<C-w>j", desc = "Go to Lower Window", icon = "" },
      { "<C-k>", "<C-w>k", desc = "Go to Upper Window", icon = "" },
      { "<C-l>", "<C-w>l", desc = "Go to Right Window", icon = "" },

      -- window management
      { "<leader>ww", "<C-W>p", desc = "Other Window", icon = "󰓩" },
      { "<leader>wd", "<C-W>c", desc = "Delete Window", icon = "" },
      { "<leader>-", "<C-W>s", desc = "Split Below", icon = "" },
      { "<leader>|", "<C-W>v", desc = "Split Right", icon = "" },

      -- terminal
      {
        "<C-l><C-l>",
        function()
          vim.fn.feedkeys("", "n")
          local sb = vim.bo.scrollback
          vim.bo.scrollback = 1
          vim.bo.scrollback = sb
        end,
        desc = "Clear Terminal Scrollback",
        icon = "󰚌",
        mode = { "t" },
      },
      { "<esc><esc>", "<c-\\><c-n>", desc = "Enter Normal Mode", mode = { "t" }, icon = "󰌌" },

      -- misc
      { "<esc>", "<cmd>noh<cr><esc>", desc = "Clear Search & Escape", mode = { "i", "n" }, icon = "󰛨" },
      { "<leader>M", "<cmd>Mason<cr>", desc = "Mason" },
    })
    wk.setup(opts)
  end,
}
