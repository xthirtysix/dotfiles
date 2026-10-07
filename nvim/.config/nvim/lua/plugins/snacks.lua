return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,

		opts = {
			picker = {
				enabled = true,
				ui_select = true,
			},

			lazygit = { enabled = true },
			gitbrowse = { enabled = true },

			indent = { enabled = false },
			notifier = { enabled = true },
			input = { enabled = true },
			words = { enabled = true },
			scroll = { enabled = false },
		},

		init = function()
			-- Snacks.toggle доступен только после загрузки плагина
			vim.api.nvim_create_autocmd("User", {
				pattern = "VeryLazy",
				callback = function()
					-- Inline-текст диагностик
					local vt_opts = { prefix = "●", spacing = 2 }
					Snacks.toggle
						.new({
							name = "Diagnostic virtual text",
							get = function()
								return vim.diagnostic.config().virtual_text ~= false
							end,
							set = function(state)
								vim.diagnostic.config({ virtual_text = state and vt_opts or false })
							end,
						})
						:map("<leader>ud")

					Snacks.toggle.indent():map("<leader>ug")
					Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
					Snacks.toggle.option("relativenumber", { name = "Relative number" }):map("<leader>uL")
				end,
			})
		end,

		keys = {
			-- git
			{
				"<leader>gg",
				function()
					Snacks.lazygit()
				end,
				desc = "Lazygit",
			},
			{
				"<leader>gl",
				function()
					Snacks.picker.git_log()
				end,
				desc = "Git log",
			},
			{
				"<leader>gL",
				function()
					Snacks.picker.git_log_file()
				end,
				desc = "Git log (file)",
			},
			{
				"<leader>gf",
				function()
					Snacks.picker.git_status()
				end,
				desc = "Git status",
			},
			{
				"<leader>gD",
				function()
					Snacks.picker.git_diff()
				end,
				desc = "Git diff (hunks)",
			},
			{
				"<leader>gc",
				function()
					Snacks.picker.git_branches()
				end,
				desc = "Git branches",
			},
			{
				"<leader>go",
				function()
					Snacks.gitbrowse()
				end,
				mode = { "n", "x" },
				desc = "Open in browser",
			},
			-- pickers
			{
				"<leader>sf",
				function()
					Snacks.picker.files()
				end,
				desc = "Find files",
			},
			{
				"<leader>sg",
				function()
					Snacks.picker.grep()
				end,
				desc = "Grep",
			},
			{
				"<leader>sw",
				function()
					Snacks.picker.grep_word()
				end,
				mode = { "n", "x" },
				desc = "Grep word / selection",
			},
			{
				"<leader>sb",
				function()
					Snacks.picker.buffers()
				end,
				desc = "Buffers",
			},
			{
				"<leader>sr",
				function()
					Snacks.picker.recent()
				end,
				desc = "Recent files",
			},
			{
				"<leader>s.",
				function()
					Snacks.picker.resume()
				end,
				desc = "Resume last picker",
			},

			-- Диагностики
			{
				"<leader>sd",
				function()
					Snacks.picker.diagnostics()
				end,
				desc = "Diagnostics (workspace)",
			},
			{
				"<leader>sD",
				function()
					Snacks.picker.diagnostics_buffer()
				end,
				desc = "Diagnostics (buffer)",
			},

			{
				"<leader>/",
				function()
					Snacks.picker.grep()
				end,
				desc = "Grep (project)",
			},
			{
				"<leader>sl",
				function()
					Snacks.picker.lines()
				end,
				desc = "Search in current file",
			},
			{
				"<leader>sB",
				function()
					Snacks.picker.grep_buffers()
				end,
				desc = "Grep open buffers",
			},
			-- Другое
			{
				"<leader>un",
				function()
					Snacks.notifier.hide()
				end,
				desc = "Dismiss notifications",
			},
			{
				"<leader>sn",
				function()
					Snacks.picker.notifications()
				end,
				desc = "Notification history",
			},
			{
				"]]",
				function()
					Snacks.words.jump(vim.v.count1)
				end,
				desc = "Next reference",
			},
			{
				"[[",
				function()
					Snacks.words.jump(-vim.v.count1)
				end,
				desc = "Prev reference",
			},
		},
	},
}
