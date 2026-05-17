-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- General
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.undofile = true
vim.opt.confirm = true

-- UI
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true
vim.opt.showmode = false
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Indentation
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.breakindent = true

-- Completion
vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- Better diff
vim.opt.diffopt:append("linematch:60")

-- Update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 500

-- Whitespace display
vim.opt.list = true
vim.opt.listchars = {
	tab = "» ",
	trail = "·",
	nbsp = "␣",
}

-- Keep 4-space indentation for these filetypes too
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("my-indent-settings", { clear = true }),
	pattern = {
		"lua",
		"python",
		"javascript",
		"typescript",
		"javascriptreact",
		"typescriptreact",
		"c",
		"cpp",
		"java",
		"cs",
		"go",
		"rust",
		"sh",
		"bash",
		"html",
		"css",
		"scss",
		"json",
		"yaml",
		"toml",
		"markdown",
	},
	callback = function()
		vim.opt_local.expandtab = true
		vim.opt_local.tabstop = 4
		vim.opt_local.softtabstop = 4
		vim.opt_local.shiftwidth = 4
	end,
})

