local conditions = require("heirline.conditions")
local blame_state = require("plugins.statusline.git-blame-state")

local LSPActive = {
	condition = conditions.lsp_attached,

	on_click = {
		callback = function()
			vim.defer_fn(function()
				vim.cmd("checkhealth vim.lsp")
			end, 100)
		end,
		name = "heirline_LSP",
	},

	-- без update: фон левого края зависит от blame строки под курсором и должен пересчитываться на каждом redraw

	flexible = 20,

	{

		{
			provider = "█",
			-- за скруглением фон pill git blame, если он активен: блоки стыкуются
			hl = function(self)
				local bg = blame_state.current() and blame_state.pill_bg(self.color_bright) or "NONE"
				return { fg = self.color_dark, bg = bg }
			end,
		},
		{
			provider = function()
				local names = {}
				for _, server in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
					table.insert(names, server.name)
				end
				return " " .. table.concat(names, ", ")
			end,
			hl = function(self)
				return { bg = self.color_dark }
			end,
		},
		{
			provider = "█",
			hl = function(self)
				return { fg = self.color_dark }
			end,
		},
	},
}

return LSPActive
