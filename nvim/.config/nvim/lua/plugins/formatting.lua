return {
	{
		"stevearc/conform.nvim",

		event = { "BufWritePre" },

		cmd = {
			"ConformInfo",
		},

		keys = {
			{
				"<leader>f",
				function()
					require("conform").format(require("core.eslint_fix").format_opts({ async = true }))
				end,
				mode = "",
				desc = "Format buffer",
			},
		},

		opts = {
			formatters_by_ft = {
				lua = { "stylua" },

				go = { "goimports", "gofumpt" },

				javascript = { "prettier" },
				javascriptreact = { "prettier" },
				typescript = { "prettier" },
				typescriptreact = { "prettier" },

				vue = { "prettier" },

				html = { "prettier" },

				css = { "prettier" },
				scss = { "prettier" },

				json = { "prettier" },
				jsonc = { "prettier" },

				yaml = { "prettier" },
				markdown = { "prettier" },
			},

			format_on_save = function()
				return require("core.eslint_fix").format_opts({ timeout_ms = 1500 })
			end,

			notify_on_error = true,
			notify_no_formatters = true,
		},
	},

	{
		"windwp/nvim-ts-autotag",
		event = { "BufReadPre", "BufNewFile" },

		opts = {
			enable_close = true,
			enable_rename = true,
			enable_close_on_slash = false,
		},
	},

	{ "nvim-mini/mini.ai", event = "VeryLazy", opts = {} },
	{ "nvim-mini/mini.surround", event = "VeryLazy", opts = {} },
}
