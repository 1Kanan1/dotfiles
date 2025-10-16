return {
  -- automatically installs and enables (vim.lsp.enable())
  "mason-org/mason-lspconfig.nvim",
  event = { "BufReadPre", "BufNewFile" },
  cmd = "Mason",
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "neovim/nvim-lspconfig",
  },
  opts = function()
    local mr = require("mason-registry")
    local mlsp = require("mason-lspconfig")

    local ensure_installed = {
      -- dap
      -- linters
      -- formatters
      "stylua",
      "prettierd",
      "sqruff",
      -- lsp
      "biome", -- prettier alternative (biome.json[c])
      "dockerls",
      "lua_ls",
      "ruff",
      "basedpyright", -- set { typeCheckingMode: false } in pyrightconfig.json
      "vtsls",
      "eslint", -- LSP, Formatter (js,jsx,ts,tsx)
      -- "oxlint",
      "rust_analyzer",
      "sqls",
      "html",
      "cssls",
      "jsonls",
      "yamlls",
      "tailwindcss",
      "svelte",
    }
    local lsp_map = mlsp.get_mappings().lspconfig_to_package
    local final_lsp = {}

    for _, pkg_name in ipairs(ensure_installed) do
      -- use "-" before the package name (like, "-stylua") to uninstall it
      local uninstall = pkg_name:sub(1, 1) == "-"
      local name = uninstall and pkg_name:sub(2) or pkg_name
      local mason_name = lsp_map[name] or name

      local ok, pkg = pcall(mr.get_package, mason_name)
      if ok then
        if uninstall and pkg:is_installed() then
          pkg:uninstall()
        elseif not uninstall then
          if not pkg:is_installed() then
            pkg:install()
          end
          if lsp_map[name] then
            table.insert(final_lsp, name) -- keep LSP names only for mason-lspconfig
          end
        end
      end
    end

    return { ensure_installed = final_lsp }
  end,
}
