return {
	{
		"AstroNvim/astrocommunity",
		{ import = "astrocommunity.completion.copilot-lua" },
		{
			"copilot.lua",
			opts = {
				suggestion = {
					keymap = {
						accept = "<C-l>",
						accept_word = false,
						accept_line = false,
						next = "<C-.>",
						prev = "<C-,>",
						dismiss = "<C/>",
					},
				},
			},
		},
		{ import = "astrocommunity.completion.copilot-lua-cmp" },
	},
}
