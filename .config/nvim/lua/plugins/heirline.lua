return {
  "rebelot/heirline.nvim",
  event = "VeryLazy",
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
    vim.api.nvim_set_hl(0, "WinBar", { link = "Normal" })
    vim.api.nvim_set_hl(0, "WinBarNC", { link = "Normal" })

    return require("components.heirline")
  end,
}
