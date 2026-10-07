local function variant(field)
	return {
		provider = function(self)
			return (self.icon and (self.icon .. " ") or "") .. self[field]
		end,
		hl = function(self)
			return { bg = self.color_bright, fg = self.color_dark }
		end,
	}
end

local FileName = {
	-- без update: init дешёвый, а разделитель должен сразу реагировать на подключение gitsigns
	init = function(self)
		local head = vim.b.gitsigns_head
		self.has_git = head ~= nil and head ~= ""

		local name = vim.api.nvim_buf_get_name(0)
		if name == "" then
			self.icon = nil
			self.full, self.short, self.tail = "[No Name]", "[No Name]", "[No Name]"
			return
		end

		local tail = vim.fn.fnamemodify(name, ":t")
		self.full = vim.fn.fnamemodify(name, ":~:.")
		self.short = vim.fn.pathshorten(self.full)
		self.tail = tail
		self.icon = require("nvim-web-devicons").get_icon(tail, vim.fn.fnamemodify(tail, ":e"), { default = true })
	end,

	{
		flexible = 2,
		variant("full"),
		variant("short"),
		variant("tail"),
	},

	{
		condition = function(self)
			return not self.has_git
		end,
		provider = "",
		hl = function(self)
			return { fg = self.color_bright, bg = self.color_dark }
		end,
	},
	{
		condition = function(self)
			return self.has_git
		end,
		provider = "",
		hl = function(self)
			return { fg = self.color_dark, bg = self.color_bright }
		end,
	},
}

return FileName
