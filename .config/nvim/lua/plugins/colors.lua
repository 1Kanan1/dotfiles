return {
  {
    "folke/tokyonight.nvim",
    enabled = true,
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        on_highlights = function(hl, _)
          hl.WinBar = { link = "Normal" }
          hl.WinBarNC = { link = "Normal" }

          hl.WhichKeyNormal = { link = "Normal" }
          hl.WhichKeyBorder = { link = "Normal" }
        end,
      })
      vim.cmd("colorscheme tokyonight-moon")
    end,
  },
}
