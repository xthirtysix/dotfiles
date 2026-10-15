local conditions = require("heirline.conditions")

local LinterActive = {
	flexible = 30,

	{
		{
			condition = conditions.lsp_attached,
			provider = "",
			hl = function(self)
				return { bg = self.color_dark }
			end,
		},
		{
			condition = function()
				return not conditions.lsp_attached
			end,
			provider = "",
			hl = function(self)
				return { fg = self.color_dark }
			end,
		},
		{
			provider = "",
			hl = function(self)
				return { fg = self.color_dark }
			end,
		},
		{
			provider = function(self)
				return " " .. table.concat(self.linters, ", ")
			end,
			hl = function(self)
				return { bg = self.color_dark }
			end,
		},
		{
			provider = "",
			hl = function(self)
				return { fg = self.color_dark }
			end,
		},
	},
}

return LinterActive
