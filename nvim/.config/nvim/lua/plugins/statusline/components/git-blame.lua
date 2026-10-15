local blame_state = require("plugins.statusline.git-blame-state")
local gitmoji = require("plugins.statusline.gitmoji")

local MAX_SUMMARY_WIDTH = 50
local DATE_FORMAT = "%d.%m.%Y"
local ICON = "\u{f417}"

local function truncate(text, width)
	if vim.fn.strchars(text) <= width then
		return text
	end
	return vim.fn.strcharpart(text, 0, width - 1) .. "…"
end

local function edge(char)
	return {
		provider = char,
		hl = function(self)
			return { fg = blame_state.pill_bg(self.color_bright), bg = "NONE" }
		end,
	}
end

local function body(format)
	return {
		edge("\u{e0b6}"),
		{
			provider = function(self)
				return format(self) .. " "
			end,
			hl = function(self)
				return { fg = "fg", bg = blame_state.pill_bg(self.color_bright) }
			end,
		},
	}
end

local UNCOMMITTED_ICON = "\u{f448}"
local UNCOMMITTED_LABEL = { add = "added", change = "changed" }

local function commit_texts(info)
	local summary = truncate(gitmoji.emojify(info.summary), MAX_SUMMARY_WIDTH)
	local date = os.date(DATE_FORMAT, tonumber(info.author_time) or 0)
	return {
		icon = ICON,
		full = string.format("%s · %s · %s", summary, info.author or "?", date),
		short = summary,
	}
end

local function uncommitted_texts(hunk_type)
	return {
		icon = UNCOMMITTED_ICON,
		full = "Uncommitted · " .. UNCOMMITTED_LABEL[hunk_type],
		short = "Uncommitted",
	}
end

local GitBlame = {
	condition = function(self)
		self.blame = blame_state.current()
		if not self.blame then
			return false
		end
		self.texts = self.blame.kind == "uncommitted" and uncommitted_texts(self.blame.hunk_type)
			or commit_texts(self.blame.info)
		return true
	end,

	on_click = {
		callback = function()
			vim.defer_fn(function()
				local state = blame_state.current()
				if state and state.kind == "uncommitted" then
					require("gitsigns").preview_hunk_inline()
				else
					require("gitsigns").blame_line({ full = true })
				end
			end, 100)
		end,
		name = "heirline_git_blame",
	},

	flexible = 10,
	body(function(self)
		return self.texts.icon .. " " .. self.texts.full
	end),
	body(function(self)
		return self.texts.icon .. " " .. self.texts.short
	end),
	body(function(self)
		return self.texts.icon
	end),
}

return GitBlame
