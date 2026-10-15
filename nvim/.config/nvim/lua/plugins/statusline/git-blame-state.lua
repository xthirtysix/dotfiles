local utils = require("plugins.statusline.heirline-utils")
local lsp_state = require("plugins.statusline.lsp-state")

local M = {}

local UNCOMMITTED_SHA = string.rep("0", 40)
local PILL_MODE_ALPHA = 0.07

local last_by_buf = {}

vim.api.nvim_create_autocmd("BufWipeout", {
	group = vim.api.nvim_create_augroup("HeirlineGitBlameState", { clear = true }),
	callback = function(args)
		last_by_buf[args.buf] = nil
	end,
})

local function has_changes(bufnr)
	local status = vim.b[bufnr].gitsigns_status_dict
	return status ~= nil and ((status.added or 0) + (status.changed or 0)) > 0
end

local function uncommitted_hunk_type(bufnr, lnum)
	if not has_changes(bufnr) then
		return nil
	end
	for _, hunk in ipairs(require("gitsigns").get_hunks(bufnr) or {}) do
		local first = hunk.added.start
		if hunk.type ~= "delete" and lnum >= first and lnum < first + hunk.added.count then
			return hunk.type
		end
	end
	return nil
end

function M.current()
	local bufnr = vim.api.nvim_get_current_buf()

	local hunk_type = uncommitted_hunk_type(bufnr, vim.api.nvim_win_get_cursor(0)[1])
	if hunk_type then
		return { kind = "uncommitted", hunk_type = hunk_type }
	end

	local info = vim.b[bufnr].gitsigns_blame_line_dict
	if info then
		last_by_buf[bufnr] = info
	else
		info = last_by_buf[bufnr]
	end

	if not info or not info.summary or info.sha == UNCOMMITTED_SHA then
		return nil
	end
	return { kind = "commit", info = info }
end

function M.pill_bg(mode_color)
	if not lsp_state.visible() then
		return utils.fade(mode_color)
	end
	return utils.fade(mode_color, PILL_MODE_ALPHA)
end

return M
