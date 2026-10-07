local conditions = require("heirline.conditions")

local function count_item(key, icon, color)
	return {
		condition = function(self)
			return (self.status_dict[key] or 0) > 0
		end,
		provider = function(self)
			return icon .. self.status_dict[key] .. " "
		end,
		hl = { fg = color },
	}
end

local function compact_item(key, color)
	return {
		condition = function(self)
			return (self.status_dict[key] or 0) > 0
		end,
		provider = function(self)
			return self.status_dict[key] .. " "
		end,
		hl = { fg = color },
	}
end

-- без правого капа, он теперь снаружи
local function wrap(children)
	return {
		condition = function(self)
			return self.has_changes
		end,
		{
			provider = "█",
			hl = function(self)
				return { fg = self.color_dark }
			end,
		},
		{
			hl = function(self)
				return { bg = self.color_dark }
			end,
			children,
		},
	}
end

local GitDiff = {
	-- содержимое: только в git-репозитории и при наличии изменений
	{
		condition = conditions.is_git_repo,

		init = function(self)
			local d = vim.b.gitsigns_status_dict or {}
			self.status_dict = d
			self.has_changes = ((d.added or 0) + (d.removed or 0) + (d.changed or 0)) > 0
		end,

		flexible = 1,
		wrap({
			count_item("added", " ", "git_add"),
			count_item("removed", " ", "git_del"),
			count_item("changed", " ", "git_change"),
		}),
		wrap({
			compact_item("added", "git_add"),
			compact_item("removed", "git_del"),
			compact_item("changed", "git_change"),
		}),
		{ provider = "" },
	},

	{
		provider = "",
		hl = function(self)
			return { fg = self.color_dark }
		end,
	},
}

return GitDiff
