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

          hl.WhichKeyNormal = { blend = 15, bg = "#222435" }
          hl.WhichKeyBorder = { blend = 15, bg = "#222435" }

          hl.BlinkCmpMenuSelection = { link = "PmenuSel" }
          hl.BlinkCmpMenu = { blend = 15, bg = "#222435" }
          hl.BlinkCmpMenuBorder = { blend = 15, bg = "#222435" }
          hl.BlinkCmpDoc = { link = "BlinkCmpMenu" }
          hl.BlinkCmpDocBorder = { link = "BlinkCmpMenuBorder" }
        end,
      })
      vim.cmd("colorscheme tokyonight-moon")
    end,
  },
}
