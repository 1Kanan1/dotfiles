return {
  "rebelot/heirline.nvim",
  event = {
    "BufReadPost", -- if I open a file inside neovim
    "BufNewFile", -- if I create/open a new file outside neovim
    "InsertEnter", -- if I use ":ene | startinsert" from snacks dashboard
  },
  exclude = { "dashboard" },
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    { "SmiteshP/nvim-navic", opts = { lsp = { auto_attach = true } } },
    { "lewis6991/gitsigns.nvim", opts = {} },
  },
  opts = function()
    -- TODO: tidy up components
    return require("components.heirline")
  end,
}
