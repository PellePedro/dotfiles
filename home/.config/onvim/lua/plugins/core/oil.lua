return {
	{
		"stevearc/oil.nvim",
		cmd = "Oil",
		-- keys = { "<leader>o" },
		keys = { "-" },
		config = function()
			require("oil").setup({
				default_file_explorer = false,
			})
			vim.keymap.set("n", "-", ":Oil<CR>", { desc = "Oil" })
		end,
	},
}
