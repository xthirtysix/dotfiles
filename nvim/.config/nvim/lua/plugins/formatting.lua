-- biome в проекте с biome.json и доступным бинарником (format + safe lint fixes + organize imports), иначе prettier
local function biome_or_prettier(bufnr)
	return require("core.root").biome(bufnr) and { "biome-check" } or { "prettier" }
end

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

				javascript = biome_or_prettier,
				javascriptreact = biome_or_prettier,
				typescript = biome_or_prettier,
				typescriptreact = biome_or_prettier,

				vue = { "prettier" },

				html = { "prettier" },

				css = biome_or_prettier,
				scss = biome_or_prettier,

				json = biome_or_prettier,
				jsonc = biome_or_prettier,

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
	{
		"nvim-mini/mini.surround",
		event = "VeryLazy",
		opts = {
			mappings = {
				add = "ys",
				delete = "ds",
				find = "",
				find_left = "",
				highlight = "",
				replace = "cs",
				suffix_last = "",
				suffix_next = "",
			},
			search_method = "cover_or_next",
		},
		config = function(_, opts)
			require("mini.surround").setup(opts)

			vim.keymap.del("x", "ys")
			vim.keymap.set("x", "S", [[:<C-u>lua MiniSurround.add('visual')<CR>]], {
				silent = true,
				desc = "Add surrounding to selection",
			})
			vim.keymap.set("n", "yss", "ys_", { remap = true, desc = "Add surrounding to line" })
		end,
	},
}
