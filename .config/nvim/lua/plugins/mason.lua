return {
  -- automatically installs and enables (vim.lsp.enable())
  "mason-org/mason-lspconfig.nvim",
  event = { "BufReadPre", "BufNewFile" },
  cmd = "Mason",
  dependencies = {
    {
      "mason-org/mason.nvim",
      config = function()
        require("mason").setup({})

        local ensure_installed = {
          -- dap
          -- linters
          -- formatters
          "stylua",
          "prettierd",
          "sqruff",
          -- lsp
          "biome", -- prettier alternative (biome.json[c])
          "lua_ls",
          "ruff",
          "pyright",
          "vtsls",
          "eslint-lsp", -- LSP, Formatter (js,jsx,ts,tsx)
          "-oxlint",
          "sqls",
          "html",
          "cssls",
          "jsonls",
          "yamlls",
          "tailwindcss",
          "svelte",
        }

        local mr = require("mason-registry")
        for _, pkg_name in ipairs(ensure_installed) do
          -- use "-" before the package name (like, "-stylua") to uninstall it
          local uninstall = pkg_name:sub(1, 1) == "-"
          local name = uninstall and pkg_name:sub(2) or pkg_name
          local ok, pkg = pcall(mr.get_package, name)
          if ok then
            if uninstall and pkg:is_installed() then
              pkg:uninstall()
            elseif not uninstall and not pkg:is_installed() then
              pkg:install()
            end
          end
        end
      end,
    },
    "neovim/nvim-lspconfig",
  },
  opts = {},
}
