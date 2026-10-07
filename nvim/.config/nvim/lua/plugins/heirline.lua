return {
	"rebelot/heirline.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-mini/mini.icons" },

	config = function()
		local heirline = require("heirline")
		local utils = require("plugins.statusline.heirline-utils")
		local hu = require("heirline.utils")

		local Common = require("plugins.statusline.components.common")
		local ViMode = require("plugins.statusline.components.vi-mode")
		local FileName = require("plugins.statusline.components.file-name")
		local Git = require("plugins.statusline.components.git")
		local GitDiff = require("plugins.statusline.components.git-diff")
		local Diagnostics = require("plugins.statusline.components.diagnostics")
		local LSPActive = require("plugins.statusline.components.lsp-active")
		local Ruler = require("plugins.statusline.components.ruler")

		utils.transparent_statusline()

		heirline.setup({
			statusline = {
				init = function(self)
					utils.init_mode(self)
					utils.init_has_git(self)
					utils.init_colors(self)
				end,
				hl = { bg = "NONE" },
				Common.Space,
				ViMode,
				FileName,
				Git,
				GitDiff,
				Common.Space,
				Diagnostics,
				Common.Align,
				LSPActive,
				Ruler,
				Common.Space,
			},
			opts = { colors = utils.colors },
		})

		vim.api.nvim_create_autocmd("ColorScheme", {
			group = vim.api.nvim_create_augroup("HeirlineColors", { clear = true }),

			callback = function()
				utils.transparent_statusline()
				hu.on_colorscheme(utils.colors)
			end,
		})
	end,
}
