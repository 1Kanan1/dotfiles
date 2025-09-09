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

      vim.api.nvim_set_hl(0, "WhichKeyNormal", { blend = 15, bg = "#1e1e1e" })
      vim.api.nvim_set_hl(0, "WhichKeyBorder", { blend = 15, bg = "#1e1e1e" })

      -- blink.cmp highlights
      local blend = 15
      local highlights = {
        { "BlinkCmpMenuSelection", { link = "PmenuSel" } },
        { "BlinkCmpMenu", { blend = blend, bg = "#1e1e1e" } },
        { "BlinkCmpMenuBorder", { blend = blend, bg = "#1e1e1e" } },
        { "BlinkCmpDoc", { link = "BlinkCmpMenu" } },
        { "BlinkCmpDocBorder", { link = "BlinkCmpMenuBorder" } },
      }
      for _, h in ipairs(highlights) do
        vim.api.nvim_set_hl(0, h[1], h[2])
      end
    end,
  },
}
