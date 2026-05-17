--# selene: allow(mixed_table, undefined_variable)

return {
	{
		"mbbill/undotree",
		cmd = "UndotreeToggle",
		keys = {
			{
				"<leader>u",
				"<cmd>UndotreeToggle<CR>",
				desc = "Toggle undo tree",
			},
		},
	},
}

