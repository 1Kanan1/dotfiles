return {
  "OXY2DEV/markview.nvim",
  ft = "markdown",

  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local presets = require("markview.presets")

    require("markview").setup({
      markdown = {
        headings = presets.headings.glow,
        horizontal_rules = presets.horizontal_rules.thick,
      },
      experimental = { check_rtp_message = false },
    })
  end,
}
