return {
  {
    "echasnovski/mini.nvim",
    config = function()
      require("mini.ai").setup()
      require("mini.pairs").setup()
      require("mini.bufremove").setup()
      require("mini.surround").setup()
      -- FIX: (mini.sessions) There is no detected sessions. Change configuration and rerun `MiniSessions.setup()`.
      require("mini.sessions").setup()
      require("mini.comment").setup({
        options = {
          custom_commentstring = function()
            return require("ts_context_commentstring").calculate_commentstring() or vim.bo.commentstring
          end,
        },
      })
    end,
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    ft = { "html", "javascript", "typescript", "svelte", "vue", "tsx", "jsx" },
  },
}
