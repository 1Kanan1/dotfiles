return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    preset = "modern",
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
      { "]", desc = "+next" },
      { "[", desc = "+prev" },
      { "<leader>b", desc = "+buffer" },

      { "[b", "<cmd>bprevious<cr>", desc = "Prev Buffer" },
      { "]b", "<cmd>bnext<cr>", desc = "Next Buffer" },

      { "<leader>c", desc = "code", icon = "" },
      { "<leader>d", desc = "DAP", icon = "󰃤" },
      { "<leader>f", desc = "Telescope (file/find)" },
      { "<leader>g", desc = "git" },
      { "<leader>s", desc = "search" },
      { "<leader>m", desc = "github", icon = "" },
      { "<leader>n", desc = "+notification" },
      { "<leader>r", desc = "CodeRunner" },

      -- movements between windows (<ctrl> hjkl)
      { "<C-h>", "<C-w>h", desc = "Go to Left Window" },
      { "<C-j>", "<C-w>j", desc = "Go to Lower Window" },
      { "<C-k>", "<C-w>k", desc = "Go to Upper Window" },
      { "<C-l>", "<C-w>l", desc = "Go to Right Window" },

      -- windows
      { "<leader>w", desc = "windows" },
      { "<leader>ww", "<C-W>p", desc = "Other Window" },
      { "<leader>wd", "<C-W>c", desc = "Delete Window" },
      { "<leader>-", "<C-W>s", desc = "Split Window Below" },
      { "<leader>|", "<C-W>v", desc = "Split Window Right" },

      -- terminal
      {
        "<C-l><C-l>",
        function()
          vim.fn.feedkeys("", "n")
          local sb = vim.bo.scrollback
          vim.bo.scrollback = 1
          vim.bo.scrollback = sb
        end,
        desc = "Clear terminal scrollback",
        mode = { "t" },
      },
      { "<esc><esc>", "<c-\\><c-n>", desc = "Enter Normal Mode", mode = { "t" } },
      { "<C-/>", "<cmd>close<cr>", desc = "Hide Terminal", mode = { "t" } },
      { "<c-_>", "<cmd>close<cr>", desc = "which_key_ignore", mode = { "t" } },

      { "<leader>x", desc = "+diagnostics/quickfix" },
      { "<esc>", "<cmd>noh<cr><esc>", desc = "Escape and Clear search", mode = { "i", "n" } },
    })
    wk.setup(opts)
  end,
}
