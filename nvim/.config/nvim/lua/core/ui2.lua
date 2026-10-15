if not has_ui2 then
	return
end

local api = vim.api
local cmdline = require("vim._core.ui2.cmdline")

local CMD_WIN_ABOVE_STATUSLINE = { relative = "laststatus", row = 0, col = 0, anchor = "SW" }

local function keep_cmdline_above_statusline()
	if vim.o.cmdheight ~= 0 then
		vim._with({ noautocmd = true, o = { splitkeep = "screen" } }, function()
			vim.o.cmdheight = 0
		end)
	end

	local win = ui2.wins.cmd
	if api.nvim_win_is_valid(win) and not api.nvim_win_get_config(win).hide then
		api.nvim_win_set_config(win, CMD_WIN_ABOVE_STATUSLINE)
	end

	vim.g.ui_cmdline_pos = { vim.o.lines - 1, 0 }
end

local cmdline_show = cmdline.cmdline_show
cmdline.cmdline_show = function(...)
	cmdline_show(...)
	keep_cmdline_above_statusline()
end

ui2.enable({ msg = { target = "msg" } })
vim.o.cmdheight = 0
