local M = {}

local fallback_bg = "#1e1e2e"
local current = {}

local function heirline_utils()
	return require("heirline.utils")
end

local function to_hex(color)
	if type(color) == "number" then
		return string.format("#%06x", color)
	end
	return color
end

local function to_rgb(color)
	local r, g, b = to_hex(color):match("^#(%x%x)(%x%x)(%x%x)$")
	return tonumber(r, 16), tonumber(g, 16), tonumber(b, 16)
end

local function blend(fg, bg, alpha)
	local fr, fg_, fb = to_rgb(fg)
	local br, bg_, bb = to_rgb(bg)

	local function mix(f, b)
		return math.floor(f * alpha + b * (1 - alpha) + 0.5)
	end

	return string.format("#%02x%02x%02x", mix(fr, br), mix(fg_, bg_), mix(fb, bb))
end

local function get(attr, ...)
	for _, name in ipairs({ ... }) do
		local value = heirline_utils().get_highlight(name)[attr]
		if value then
			return to_hex(value)
		end
	end
end

M.mode_colors = {
	n = "blue",
	i = "green",
	v = "purple",
	V = "purple",
	["\22"] = "purple",
	c = "orange",
	s = "cyan",
	S = "cyan",
	["\19"] = "cyan",
	R = "orange",
	r = "orange",
	["!"] = "red",
	t = "cyan",
}

function M.colors()
	current = {
		bg = get("bg", "Normal", "StatusLine") or fallback_bg,
		bright_bg = get("bg", "Folded"),
		bright_fg = get("fg", "Folded"),

		red = get("fg", "DiagnosticError"),
		dark_red = get("bg", "DiffDelete"),
		green = get("fg", "String"),
		blue = get("fg", "Function"),
		gray = get("fg", "NonText"),
		orange = get("fg", "Constant"),
		purple = get("fg", "Statement"),
		cyan = get("fg", "Special"),

		diag_warn = get("fg", "DiagnosticWarn") or "yellow",
		diag_error = get("fg", "DiagnosticError") or "red",
		diag_hint = get("fg", "DiagnosticHint") or "cyan",
		diag_info = get("fg", "DiagnosticInfo") or "green",

		git_add = get("fg", "GitSignsAdd", "Added", "diffAdded") or "green",
		git_change = get("fg", "GitSignsChange", "Changed", "diffChanged") or "yellow",
		git_del = get("fg", "GitSignsDelete", "Removed", "diffRemoved") or "red",
	}
	return current
end

function M.fade(color, amount)
	local resolved = current[color] or color
	return blend(resolved, current.bg or fallback_bg, amount or 0.15)
end

function M.transparent_statusline()
	for _, group in ipairs({ "StatusLine", "StatusLineNC" }) do
		local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
		hl.bg = "NONE"
		hl.reverse = false
		vim.api.nvim_set_hl(0, group, hl)
	end
end

function M.init_mode(self)
	self.mode = vim.fn.mode(1)
end

function M.init_has_git(self)
	self.has_git = vim.b.gitsigns_status_dict ~= nil
end

function M.init_colors(self)
	local name = M.mode_colors[vim.fn.mode(1):sub(1, 1)] or "gray"
	self.color_bright = name
	self.color_dark = M.fade(name)
end

return M
