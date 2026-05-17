--# selene: allow(mixed_table, undefined_variable)

return {
	{
		"stevearc/oil.nvim",
		cmd = "Oil",
		keys = {
			{
				"-",
				"<cmd>Oil<CR>",
				desc = "Open parent directory",
			},
		},
		opts = {
			default_file_explorer = false,
			view_options = {
				show_hidden = true,
			},
		},
	},
}

