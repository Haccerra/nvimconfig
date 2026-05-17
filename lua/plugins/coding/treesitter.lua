--# selene: allow(mixed_table, undefined_variable)

local parsers = {
	-- Core
	"lua",
	"vim",
	"vimdoc",
	"query",

	-- C / C++
	"c",
	"cpp",

	-- Go
	"go",
	"gomod",

	-- Rust
	"rust",

	-- Java
	"java",

	-- Python
	"python",

	-- JavaScript / TypeScript
	"javascript",
	"typescript",
	"tsx",

	-- HTML / CSS
	"html",
	"css",

	-- Shell
	"bash",

	-- Clojure / Lisp-family
	"clojure",

	-- Perl
	"perl",

	-- C#
	"c_sharp",

	-- Common config/data formats
	"json",
	"yaml",
	"toml",
	"markdown",
	"markdown_inline",
}

return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			local ts = require("nvim-treesitter")

			ts.setup({
				install_dir = vim.fn.stdpath("data") .. "/site",
			})

			ts.install(parsers)

			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("my-treesitter", { clear = true }),
				pattern = parsers,
				callback = function()
					vim.treesitter.start()
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})
		end,
	},
}

