local M = {}

M.EVENT = "StatuslineLspToggled"

function M.enabled()
	return vim.g.statusline_lsp_enabled == true
end

function M.set(state)
	vim.g.statusline_lsp_enabled = state
	vim.api.nvim_exec_autocmds("User", { pattern = M.EVENT })
	vim.cmd("redrawstatus")
end

function M.visible()
	return M.enabled() and next(vim.lsp.get_clients({ bufnr = 0 })) ~= nil
end

return M
