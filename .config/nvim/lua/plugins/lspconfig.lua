return {
  'neovim/nvim-lspconfig',
  dependencies = { 'saghen/blink.cmp' },

  -- example using `opts` for defining servers
  opts = function(_, opts)
    opts.servers = {
			lua_ls = {
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
						},
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							checkThirdParty = false,
							library = {
								vim.env.VIMRUNTIME,
							},
						},
						-- telemetry = {
						-- },
						hint = {},
					},
				},
			},
			gopls = {},
			yamlls = {},
			html = {
				-- cmd = { "vscode-html-language-server", "--stdio" },
				filetypes = { "html" },
				root_dir = require("lspconfig").util.root_pattern(".git", "package.json"),
			},
			htmx = {},
			ruff = {},
			svelte = {},
			-- pylsp = {},
			pyright = {},
			-- jedi_language_server = {},
			cssls = {},
			ts_ls = {
				single_file_support = true,
				root_dir = require("lspconfig").util.root_pattern("tsconfig.json", "package.json", "jsconfig.json", ".git"),
				filetypes = {
					"javascript",
					"javascriptreact",
					"javascript.jsx",
					"typescript",
					"typescriptreact",
					"typescript.tsx",
				},
				settings = {
					javascript = {
						inlayHints = {
							includeInlayEnumMemberValueHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
							includeInlayParameterNameHintsWhenArgumentMatchesName = true,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayVariableTypeHints = false,
						},
					},

					typescript = {
						inlayHints = {
							includeInlayEnumMemberValueHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayParameterNameHints = "literals", -- 'none' | 'literals' | 'all';
							includeInlayParameterNameHintsWhenArgumentMatchesName = true,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayVariableTypeHints = true,
						},
					},
				},
			},
			tailwindcss = {
				single_file_support = false,
				-- cmd = { "tailwindcss-language-server", "--stdio" },
				filetypes = {
					"html",
					"htmldjango",
					"css",
					"svelte",
					"javascript",
					"typescript",
					"javascriptreact",
					"typescriptreact",
					"json",
				},
				root_dir = require("lspconfig").util.root_pattern(
					"tailwind.config.js",
					"tailwind.config.cjs",
					"tailwind.config.ts",
					"pyproject.toml",
					"package.json",
					".git"
				),
			},
			marksman = {},
    }
  end,
  config = function(_, opts)
    local lspconfig = require('lspconfig')
    for server, config in pairs(opts.servers) do
      -- passing config.capabilities to blink.cmp merges with the capabilities in your
      -- `opts[server].capabilities, if you've defined it
      config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
      lspconfig[server].setup(config)
    end
  end
}
