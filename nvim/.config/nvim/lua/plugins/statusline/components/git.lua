local Git = {
	condition = function(self)
		self.head = vim.b.gitsigns_head
		return self.head ~= nil and self.head ~= ""
	end,

	on_click = {
		callback = function()
			vim.defer_fn(function()
				vim.cmd("lua Snacks.picker.git_branches()")
			end, 100)
		end,
		name = "heirline_git",
	},

	flexible = 2,
	{
		{
			provider = function()
				return "█"
			end,
			hl = function(self)
				return { fg = self.color_bright }
			end,
		},
		{
			provider = function(self)
				return "" .. " " .. self.head
			end,
			hl = function(self)
				return { fg = self.color_dark, bg = self.color_bright }
			end,
		},
		{
			provider = "█",
			hl = function(self)
				return { fg = self.color_bright, bg = self.has_git_changes and self.color_dark or "NONE" }
			end,
		},
	},
}

return Git
