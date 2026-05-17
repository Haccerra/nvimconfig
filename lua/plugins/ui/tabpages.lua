--# selene: allow(mixed_table, undefined_variable)

return {
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		event = "VeryLazy",
		opts = {
			options = {
				mode = "buffers",
				separator_style = "slant",
				show_buffer_close_icons = true,
				show_close_icon = false,
				diagnostics = "nvim_lsp",

				offsets = {
					{
						filetype = "neo-tree",
						text = "File Explorer",
						text_align = "center",
						separator = true,
					},
				},
			},
		},
		keys = {
			{
				"<S-h>",
				"<cmd>BufferLineCyclePrev<CR>",
				desc = "Previous buffer",
			},
			{
				"<S-l>",
				"<cmd>BufferLineCycleNext<CR>",
				desc = "Next buffer",
			},
			{
				"<leader>bp",
				"<cmd>BufferLineTogglePin<CR>",
				desc = "Pin buffer",
			},
			{
				"<leader>bc",
				"<cmd>bdelete<CR>",
				desc = "Close buffer",
			},
			{
				"<leader>bC",
				"<cmd>BufferLineCloseOthers<CR>",
				desc = "Close other buffers",
			},
		},
	},
}

