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
    {
      "Bekaboo/dropbar.nvim",
      config = function()
        local dropbar_api = require("dropbar.api")
        vim.keymap.set("n", "<Leader>;", dropbar_api.pick, { desc = "Pick symbols in winbar" })
        vim.keymap.set("n", "[;", dropbar_api.goto_context_start, { desc = "Go to start of current context" })
        vim.keymap.set("n", "];", dropbar_api.select_next_context, { desc = "Select next context" })
      end,
    },
    { "lewis6991/gitsigns.nvim", opts = {} },
  },
  opts = function()
    -- TODO: tidy up components
    return require("components.heirline")
  end,
}
