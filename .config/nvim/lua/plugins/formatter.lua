return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  cmd = "ConformInfo",
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "ruff" },
        html = { "prettierd", "djlint" },
        htmldjango = { "ruff" },
        -- htmldjango = { "djlint" },
        css = { "prettierd" },
        scss = { "prettierd" },
        javascript = { "prettierd", "eslint_d" },
        javascriptreact = { "prettierd", "eslint_d" },
        typescript = { "prettierd", "eslint_d" },
        typescriptreact = { "prettierd", "eslint_d" },
        json = { "prettierd" },
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
