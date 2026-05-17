--# selene: allow(mixed_table, undefined_variable)

return {
	{
		"folke/todo-comments.nvim",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		opts = {},
		keys = {
			{
				"<leader>xt",
				"<cmd>TodoTrouble<CR>",
				desc = "Todo comments",
			},
			{
				"<leader>st",
				"<cmd>TodoTelescope<CR>",
				desc = "Search todo comments",
			},
		},
	},
}

