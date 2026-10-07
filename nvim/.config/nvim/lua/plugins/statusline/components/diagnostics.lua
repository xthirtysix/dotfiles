local conditions = require("heirline.conditions")
local sev = vim.diagnostic.severity

local function icon(severity, fallback)
	local signs = vim.diagnostic.config().signs
	local text = type(signs) == "table" and type(signs.text) == "table" and signs.text[severity]
	return text or fallback
end

local function item(severity, fallback, color)
	return {
		condition = function(self)
			return (self.count[severity] or 0) > 0
		end,
		provider = function(self)
			return icon(severity, fallback) .. " " .. self.count[severity] .. " "
		end,
		hl = { fg = color },
	}
end

local Diagnostics = {
	condition = conditions.has_diagnostics,
	update = { "DiagnosticChanged", "BufEnter" },

	init = function(self)
		self.count = vim.diagnostic.count(0)
	end,

	item(sev.ERROR, "E", "diag_error"),
	item(sev.WARN, "W", "diag_warn"),
	item(sev.INFO, "I", "diag_info"),
	item(sev.HINT, "H", "diag_hint"),
}

return Diagnostics
