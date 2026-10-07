return {
	{ "shatur/neovim-ayu" },
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
		enabled = false,
		config = function()
			require("kanagawa").setup({
				-- фон берётся из терминала
				transparent = true,
				colors = {
					theme = {
						all = {
							ui = {
								-- без отдельного фона у колонки знаков/номеров
								bg_gutter = "none",
							},
						},
					},
				},
				overrides = function(colors)
					local theme = colors.theme
					return {
						-- прозрачные плавающие окна
						NormalFloat = { bg = "none" },
						FloatBorder = { bg = "none" },
						FloatTitle = { bg = "none" },
						-- меню автодополнения
						Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
						PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
					}
				end,
				theme = "wave",
				background = {
					dark = "wave",
					light = "lotus",
				},
			})

			vim.cmd.colorscheme("kanagawa")
		end,
	},
}
