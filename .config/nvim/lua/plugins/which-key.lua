return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
	opts = {
		preset = "modern",
		plugins = { spelling = true },
		icons = {
			group = "",
		},
		mode = {
			n = true,
			v = true,
		},
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.add({
			{ "]", desc = "+next" },
			{ "[", desc = "+prev" },
			{ "<leader><tab>", desc = "tabs" },
			{ "<leader>b", desc = "+buffer" },
			{ "<leader>c", desc = "code", icon = "" },
			{ "<leader>d", desc = "DAP", icon = "󰃤" },
			{ "<leader>f", desc = "Telescope (file/find)" },
			{ "<leader>g", desc = "git" },
			{ "<leader>s", desc = "search" },
			{ "<leader>m", desc = "github", icon = "" },
			{ "<leader>n", desc = "+notification" },
			{ "<leader>r", desc = "CodeRunner" },
			{ "<leader>w", desc = "windows" },
			{ "<leader>x", desc = "+diagnostics/quickfix" },
			{ "<leader>t", desc = "terminal" },
		})
		wk.setup(opts)
		-- wk.register(opts.defaults)
	end,
}
