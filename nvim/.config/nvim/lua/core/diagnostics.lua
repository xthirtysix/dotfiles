local sev = vim.diagnostic.severity

vim.diagnostic.config({
	signs = {
		text = {
			[sev.ERROR] = "\u{f057}", -- nf-fa-times_circle
			[sev.WARN] = "\u{f071}", -- nf-fa-warning
			[sev.INFO] = "\u{f05a}", -- nf-fa-info_circle
			[sev.HINT] = "\u{f0eb}", -- nf-fa-lightbulb_o
			-- [sev.ERROR] = "✘",
			-- [sev.WARN] = "▲",
			-- [sev.INFO] = "●",
			-- [sev.HINT] = "⚑",
		},
		numhl = {
			[sev.ERROR] = "DiagnosticSignError",
			[sev.WARN] = "DiagnosticSignWarn",
			[sev.INFO] = "DiagnosticSignInfo",
			[sev.HINT] = "DiagnosticSignHint",
		},
	},
	virtual_text = false,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = "if_many",
	},
})

local map = vim.keymap.set

local function jump(count, severity)
	return function()
		vim.diagnostic.jump({ count = count, severity = severity, float = true })
	end
end

-- Навигация: все диагностики / только ошибки
map("n", "]d", jump(1), { desc = "Next diagnostic" })
map("n", "[d", jump(-1), { desc = "Prev diagnostic" })
map("n", "]e", jump(1, sev.ERROR), { desc = "Next error" })
map("n", "[e", jump(-1, sev.ERROR), { desc = "Prev error" })

-- Список диагностик: <leader>sd / <leader>sD, toggle virtual text: <leader>ud (snacks.lua)
