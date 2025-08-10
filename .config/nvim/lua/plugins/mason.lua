return {
	-- Package Manager for LSP, Formatters, DAP servers, and linters
	{
		"mason-org/mason.nvim",
		cmd = "Mason",
    event = "VeryLazy",
		build = ":MasonUpdate",
		config = function()
			require("mason").setup({})

			local formatters = {
				"prettier",
				--htmldjango
				"djlint", -- formatter, linter
				-- python
				"-autopep8",
				"black",
				"-isort",
				-- lua
				"stylua",
			}
			local dap = {
				"js-debug-adapter",
			}
			local linters = {
				-- python
				"-flake8",
				"mypy",
			}
			local ensure_installed = { dap, linters, formatters }

			local mr = require("mason-registry")
			for _, tbl in ipairs(ensure_installed) do
				for _, package in ipairs(tbl) do
					-- use "-" before the package name (like, "-stylua") to uninstall it
					if package:find("%-") ~= nil then
						local ok, pkg = pcall(mr.get_package, package:sub(2))
						if ok and pkg:is_installed() then
							pkg:uninstall()
						end
					else
						local ok, pkg = pcall(mr.get_package, package)
						if ok and not pkg:is_installed() then
							pkg:install()
						end
					end
				end
			end
		end,
	},
	-- Package Manager for LSP installation
	{
		"mason-org/mason-lspconfig.nvim",
    event = "VeryLazy",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					-- LUA
					"lua_ls",

					-- GOLANG
					"gopls",

					-- PYTHON
					"ruff",
					-- "pylsp",
					"pyright",
					-- "jedi_language_server",

					"yamlls",

					-- HTML
					"html",
					"htmx",

					-- CSS
					"cssls",
					"tailwindcss",

					"ts_ls",

					"svelte",

					"marksman", -- markdown
				},
				automatic_enable = false,
			})
		end,
	},
}
