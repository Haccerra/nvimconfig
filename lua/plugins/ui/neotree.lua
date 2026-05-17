--# selene: allow(mixed_table, undefined_variable)

return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "MunifTanjim/nui.nvim" },
			{
				"nvim-tree/nvim-web-devicons",
				opts = {
					default = true,
				},
			},
		},
		config = function()
			require("neo-tree").setup({
				window = {
					position = "right",
				},

				default_component_configs = {
					icon = {
						folder_closed = "",
						folder_open = "",
						folder_empty = "󰜌",
						default = "󰈚",
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
		end,
	},
}

