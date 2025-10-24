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
      picker = {
        sources = {
          explorer = {
            layout = { layout = { position = "right" } },
          },
        },
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
