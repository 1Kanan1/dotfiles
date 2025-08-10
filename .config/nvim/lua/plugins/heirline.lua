return {
  "rebelot/heirline.nvim",
  event = { "VimEnter", "BufWinEnter", "FileType", "VeryLazy" },
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "SmiteshP/nvim-navic",
    { "lewis6991/gitsigns.nvim", opts = {} },
  },
  opts = function()
    return require("components.heirline")
  end,
}
