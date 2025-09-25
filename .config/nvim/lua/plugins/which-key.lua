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
    -- TODO: tidy up
    wk.add({
      -- group labels
      { "]", desc = "+next" },
      { "[", desc = "+prev" },
      { "<leader>c", desc = "+code", icon = "" },
      { "<leader>d", desc = "+debug (DAP)", icon = "" },
      { "<leader>f", desc = "+find/file (Telescope)" },
      { "<leader>L", "<cmd>LspInfo<cr>", desc = "LSP Info" },
      { "<leader>m", "<cmd>Mason<cr>", desc = "Mason" },
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
      { "<leader>w", desc = "+window", icon = "" },
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

      -- misc
      { "<esc>", "<cmd>noh<cr><esc>", desc = "Clear Search & Escape", mode = { "i", "n" }, icon = "󰛨" },
      { "dD", ":%d<cr>", desc = "Delete the whole buffer", icon = "󰧧" },
    })
    wk.setup(opts)
  end,
}
