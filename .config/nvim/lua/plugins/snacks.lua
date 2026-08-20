return {
  {
    "snacks.nvim",
    opts = {
      dashboard = require("components.snacks.dashboard").opts,
      indent = {
        animate = {
          enabled = false,
        },
        chunk = {
          enabled = true,
        },
      },
      image = { enabled = true },
      picker = {
        sources = {
          explorer = {
            layout = { layout = { position = "right" } },
          },
        },
      },
      statuscolumn = {
        folds = {
          open = true,
          git_hl = true,
        },
      },
      terminal = {
        win = { position = "float" },
      },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
    },
  },
}
