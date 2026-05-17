--# selene: allow(mixed_table)
return {
	{
		"nvimtools/none-ls.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvimtools/none-ls-extras.nvim",
			"gbprod/none-ls-shellcheck.nvim",
		},
		config = function()
			local null_ls = require("null-ls")

			local formatting = null_ls.builtins.formatting
			local diagnostics = null_ls.builtins.diagnostics
			local code_actions = null_ls.builtins.code_actions

			vim.keymap.set("n", "<leader>gf", function()
				vim.lsp.buf.format({
					async = true,
				})
			end, {
				desc = "Format buffer",
			})

			local function has_eslint_config(utils)
				return utils.root_has_file({
					"eslint.config.js",
					"eslint.config.mjs",
					"eslint.config.cjs",
					".eslintrc",
					".eslintrc.js",
					".eslintrc.cjs",
					".eslintrc.json",
					".eslintrc.yaml",
					".eslintrc.yml",
				})
			end

			local function has_stylelint_config(utils)
				return utils.root_has_file({
					"stylelint.config.js",
					"stylelint.config.cjs",
					"stylelint.config.mjs",
					".stylelintrc",
					".stylelintrc.json",
					".stylelintrc.yaml",
					".stylelintrc.yml",
				})
			end

			null_ls.setup({
				sources = {
					-- C / C++
					formatting.clang_format.with({
						filetypes = { "c", "cpp" },
					}),

					diagnostics.cppcheck,

					-- Go
					formatting.gofmt,
					diagnostics.golangci_lint,
					code_actions.gomodifytags,
					code_actions.impl,

					-- Java
					formatting.google_java_format,

					-- Python
					formatting.black,
					formatting.isort,
					require("none-ls.diagnostics.ruff"),

					-- Lua
					formatting.stylua,
					diagnostics.selene,

					-- JavaScript / TypeScript / HTML / CSS / Markdown / JSON / YAML
					formatting.prettier.with({
						filetypes = {
							"javascript",
							"javascriptreact",
							"typescript",
							"typescriptreact",
							"html",
							"css",
							"scss",
							"less",
							"json",
							"yaml",
							"markdown",
						},
					}),

					require("none-ls.diagnostics.eslint_d").with({
						condition = has_eslint_config,
					}),

					require("none-ls.code_actions.eslint").with({
						condition = has_eslint_config,
					}),

					diagnostics.stylelint.with({
						condition = has_stylelint_config,
					}),

					diagnostics.markuplint,

					-- Shell / Bash / sh
					formatting.shfmt,

					require("none-ls-shellcheck.diagnostics"),
					require("none-ls-shellcheck.code_actions"),

					-- Assembly
					formatting.asmfmt,

					-- Clojure / Lisp-family
					formatting.cljfmt,
					diagnostics.clj_kondo,

					-- Perl
					diagnostics.perlimports,

					-- C#
					formatting.csharpier,

					-- General Git code actions
					code_actions.gitsigns,
				},
			})
		end,
	},
}

