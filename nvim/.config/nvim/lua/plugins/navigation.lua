return {
	-- единый набор иконок; плагины, ждущие nvim-web-devicons, получают mock от mini.icons
	{
		"nvim-mini/mini.icons",
		lazy = true,
		opts = {},
		init = function()
			package.preload["nvim-web-devicons"] = function()
				require("mini.icons").mock_nvim_web_devicons()
				return package.loaded["nvim-web-devicons"]
			end
		end,
	},

	{
		"nvim-mini/mini.files",
		version = false,

		dependencies = {
			"nvim-mini/mini.icons",
		},

		-- netrw отключён: `nvim <dir>` должен сразу открывать mini.files
		init = function()
			if vim.fn.argc(-1) == 1 and vim.fn.isdirectory(vim.fn.argv(0)) == 1 then
				require("lazy").load({ plugins = { "mini.files" } })
			end
		end,

		keys = {
			{
				"<leader>e",
				function()
					local buf = vim.api.nvim_buf_get_name(0)
					local path = (buf ~= "" and vim.uv.fs_stat(buf)) and buf or nil
					local mf = require("mini.files")

					mf.open(path, false)
					mf.reveal_cwd()
				end,
				desc = "Explorer (current file)",
			},
		},

		opts = {
			use_as_default_explorer = true,

			content = {
				filter = function(fs_entry)
					return fs_entry.name ~= ".DS_Store"
				end,
			},
		},
	},

	{
		"folke/flash.nvim",
		event = "VeryLazy",

		opts = {
			modes = {
				char = { enabled = true, jump_labels = true },
				search = { enabled = false },
			},
		},

		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash jump",
			},
			{
				"S",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote flash",
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Treesitter search",
			},
			{
				"<c-s>",
				mode = "c",
				function()
					require("flash").toggle()
				end,
				desc = "Toggle flash search",
			},
		},
	},
}
