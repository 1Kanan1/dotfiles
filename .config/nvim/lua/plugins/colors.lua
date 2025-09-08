return {
  {
    -- TODO: fix heirline and highlights issue (blink's transparency, which-key, etc.)
    "folke/tokyonight.nvim",
    enabled = true,
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup()
      vim.cmd("colorscheme tokyonight-moon")

      -- highlight overrides
      vim.api.nvim_set_hl(0, "WinBar", { link = "Normal" })
      vim.api.nvim_set_hl(0, "WinBarNC", { link = "Normal" })

      vim.api.nvim_set_hl(0, "WhichKeyNormal", { default = true, blend = 20, bg = "NONE" })
      vim.api.nvim_set_hl(0, "WhichKeyBorder", { default = true, blend = 20, bg = "NONE" })
    end,
  },
}
