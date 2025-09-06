return {
  {
    "navarasu/onedark.nvim",
    enabled = true,
    lazy = false,
    priority = 1000,
    opts = {
      style = "deep",
    },
    config = function(_, opts)
      require("onedark").setup(opts)
      vim.cmd("colorscheme onedark")

      -- highlight overrides
      vim.api.nvim_set_hl(0, "WinBar", { link = "Normal" })
      vim.api.nvim_set_hl(0, "WinBarNC", { link = "Normal" })

      vim.api.nvim_set_hl(0, "WhichKeyNormal", { default = true, blend = 20, bg = "NONE" })
      vim.api.nvim_set_hl(0, "WhichKeyBorder", { default = true, blend = 20, bg = "NONE" })
    end,
  },
}
