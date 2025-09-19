return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  cmd = "ConformInfo",
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "ruff" },
        html = { "prettierd" },
        htmldjango = { "ruff" },
        css = { "prettierd" },
        scss = { "prettierd" },
        javascript = { "biome", "eslint_d" },
        javascriptreact = { "biome", "eslint_d" },
        typescript = { "biome", "eslint_d" },
        typescriptreact = { "biome", "eslint_d" },
        sql = { "sqruff" },
        json = { "biome" },
        markdown = { "prettierd" },
        vue = { "prettierd" },
        yaml = { "prettierd" },
      },
      format_on_save = {
        timeout_ms = 3000,
        lsp_format = "fallback",
      },
    })
  end,
}
