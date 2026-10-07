return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",

		opts = {
			preset = "modern",
			delay = 300,

			spec = {
				{ "<leader>s", group = "Search" },
				{ "<leader>g", group = "Git" },
				{ "<leader>c", group = "Code / LSP" },
				{ "<leader>r", group = "Rename" },
				{ "[", group = "Prev" },
				{ "]", group = "Next" },
				{ "<leader>u", group = "UI" },
				{ "<leader>d", group = "Debug" },
			},
		},

		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer-local keymaps",
			},
		},
	},
}
