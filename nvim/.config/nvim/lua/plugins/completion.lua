return {
	{
		"saghen/blink.cmp",
		version = "2.*",

		dependencies = {
			"saghen/blink.lib",
		},

		build = function()
			require("blink.cmp").build():pwait()
		end,

		opts = {
			keymap = {
				preset = "none",

				["<C-j>"] = { "select_next", "fallback" },
				["<C-k>"] = { "select_prev", "fallback" },

				["<C-l>"] = { "select_and_accept", "fallback" },
				["<C-h>"] = { "cancel", "fallback" },

				["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-b>"] = { "scroll_documentation_up", "fallback" },
				["<C-f>"] = { "scroll_documentation_down", "fallback" },

				["<Tab>"] = {
					"snippet_forward",
					"select_next",
					"fallback",
				},

				["<S-Tab>"] = {
					"snippet_backward",
					"select_prev",
					"fallback",
				},
			},

			completion = {
				documentation = {
					auto_show = false,
				},
			},

			snippets = { preset = "default" },

			sources = {
				default = {
					"lazydev",
					"lsp",
					"path",
					"snippets",
					"buffer",
				},

				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						score_offset = 100,
					},
				},
			},

			fuzzy = {
				implementation = "prefer_rust_with_warning",
			},
		},
	},
}
