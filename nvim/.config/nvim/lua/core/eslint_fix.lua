-- ESLint fix через LSP-форматирование eslint (settings.format = true в after/lsp/eslint.lua):
-- conform запускает его перед prettier в одном проходе, без отдельного синхронного запроса
local M = {}

if vim.g.eslint_fix_on_save == nil then
	vim.g.eslint_fix_on_save = true
end

-- опции для conform.format: eslint (если включён) -> formatters_by_ft
function M.format_opts(opts)
	return vim.tbl_extend("force", opts or {}, {
		lsp_format = vim.g.eslint_fix_on_save and "first" or "never",
		name = "eslint",
	})
end

vim.api.nvim_create_user_command("ToggleEslintFix", function()
	vim.g.eslint_fix_on_save = not vim.g.eslint_fix_on_save
	vim.notify("ESLint fix on save: " .. tostring(vim.g.eslint_fix_on_save))
end, {})

return M
