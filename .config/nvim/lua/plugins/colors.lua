return {
	{
		"navarasu/onedark.nvim",
		enabled = true,
		lazy = false,
		priority = 1000,
		opts = {
			style = "deep",
		},
		config = function(_, opts)
			require("onedark").setup(opts)
			vim.cmd("colorscheme onedark")
		end,
	},
}
