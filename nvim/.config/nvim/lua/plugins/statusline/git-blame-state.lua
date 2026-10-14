-- общее состояние git blame для statusline: используется блоком blame и стыкующимся с ним блоком LSP
local utils = require("plugins.statusline.heirline-utils")

local M = {}

local UNCOMMITTED_SHA = string.rep("0", 40)
-- доля цвета режима поверх фона темы; меньше, чем у LSP (0.15), — ступень градиента blame -> lsp -> ruler
local PILL_MODE_ALPHA = 0.07

-- gitsigns сбрасывает blame на каждом CursorMoved и выставляет заново после delay;
-- держим последний результат, чтобы блок не моргал во время движения курсора
local last_by_buf = {}

vim.api.nvim_create_autocmd("BufWipeout", {
	group = vim.api.nvim_create_augroup("HeirlineGitBlameState", { clear = true }),
	callback = function(args)
		last_by_buf[args.buf] = nil
	end,
})

--- @return boolean есть ли у буфера добавленные или изменённые строки относительно индекса
local function has_changes(bufnr)
	local status = vim.b[bufnr].gitsigns_status_dict
	return status ~= nil and ((status.added or 0) + (status.changed or 0)) > 0
end

--- @return "add"|"change"|nil тип незакоммиченного hunk'а, в который попадает строка
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

--- @return { kind: "uncommitted", hunk_type: "add"|"change" }|{ kind: "commit", info: table }|nil
--- что показывать для строки под курсором; nil, если показывать нечего
function M.current()
	local bufnr = vim.api.nvim_get_current_buf()

	-- hunk'и gitsigns обновляются при каждом изменении текста, blame — только после delay,
	-- поэтому незакоммиченную правку определяем по ним, а не по устаревшему blame
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

--- @param mode_color string имя цвета режима (self.color_bright)
function M.pill_bg(mode_color)
	return utils.fade(mode_color, PILL_MODE_ALPHA)
end

return M
