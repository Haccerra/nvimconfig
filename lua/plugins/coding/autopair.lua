--# selene: allow(mixed_table, undefined_variable)

return {
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {
			check_ts = true,
		},
		config = function(_, opts)
			require("nvim-autopairs").setup(opts)

			local ok_cmp, cmp = pcall(require, "cmp")
			local ok_pairs, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")

			if ok_cmp and ok_pairs then
				cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
			end
		end,
	},
}

