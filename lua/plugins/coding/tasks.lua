--# selene: allow(mixed_table, undefined_variable)

return {
	{
		"stevearc/overseer.nvim",
		cmd = {
			"OverseerRun",
			"OverseerToggle",
			"OverseerRestartLast",
		},
		opts = {},
		keys = {
			{
				"<leader>or",
				"<cmd>OverseerRun<CR>",
				desc = "Run task",
			},
			{
				"<leader>oo",
				"<cmd>OverseerToggle<CR>",
				desc = "Toggle tasks",
			},
			{
				"<leader>ol",
				"<cmd>OverseerRestartLast<CR>",
				desc = "Restart last task",
			},
		},
	},
}

