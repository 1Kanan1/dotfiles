local o = vim.opt

local options = {
	shell = "/opt/homebrew/bin/fish",
	shellcmdflag = "-c",
	clipboard = "unnamedplus",
	confirm = true,
	cursorline = true,
	expandtab = true,
	formatoptions = "jcroqlnt", -- tcqj
	ignorecase = true,
	laststatus = 3,
	mouse = "a",
	number = true,
	numberwidth = 3,
	relativenumber = true,
	scrolloff = 4,
	shiftwidth = 2,
	showmode = false,
	signcolumn = "yes",
	smartcase = true,
	smartindent = true,
	splitbelow = true,
	splitkeep = "screen",
	splitright = true,
	tabstop = 2,
	termguicolors = true,
	virtualedit = "block",
}

for key, value in pairs(options) do
	o[key] = value
end
