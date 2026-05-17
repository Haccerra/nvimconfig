--# selene: allow(mixed_table, undefined_variable)

return {
	{
		"nvim-tree/nvim-web-devicons",
		opts = {
			default = true,
		},
	},

	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("neo-tree").setup({
				close_if_last_window = false,
				enable_git_status = true,
				enable_diagnostics = true,

				window = {
					position = "right",
					width = 35,

					mappings = {
						["<CR>"] = "toggle_node",
						["<space>"] = "toggle_node",
						["l"] = "open",
						["h"] = "close_node",
						["q"] = "close_window",
					},
				},

				filesystem = {
					filtered_items = {
						visible = true,
						hide_dotfiles = false,
						hide_gitignored = false,
					},
				},
			})

			vim.keymap.set("n", "<C-n>", "<cmd>Neotree toggle<CR>", {
				desc = "Toggle Neo-tree",
				silent = true,
			})

			vim.keymap.set("n", "<leader>nf", "<cmd>Neotree filesystem focus<CR>", {
				desc = "Focus Neo-tree",
				silent = true,
			})
		end,
	},
}

