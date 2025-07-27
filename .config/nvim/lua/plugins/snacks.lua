return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  dependencies = {
    {
      "kevinhwang91/nvim-ufo",
      dependencies = {
        "kevinhwang91/promise-async",
      },
      event = "VeryLazy",
      config = function()
        vim.o.foldlevel = 99
        vim.o.foldlevelstart = 99

        require("ufo").setup({
          provider_selector = function(bufnr, filetype, buftype)
            return { "treesitter", "indent" }
          end,
        })
      end,
    },
  },
  ---@type snacks.Config
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
		dashboard = require("components.snacks.dashboard").opts,
    explorer = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    picker = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
		statuscolumn = require("components.snacks.statuscolumn").opts,
    words = { enabled = true },
  },
}
