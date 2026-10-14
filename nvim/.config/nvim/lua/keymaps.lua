local map = vim.keymap.set

local opts = { noremap = true, silent = true }

map("n", "Q", "<Nop>", opts)
map("n", "<Esc>", "<cmd>nohlsearch<CR>", opts)

map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

map("n", "<C-Up>", "<cmd>resize +2<CR>", opts)
map("n", "<C-Down>", "<cmd>resize -2<CR>", opts)
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", opts)
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", opts)

map("x", "J", ":m '>+1<CR>gv=gv", opts)
map("x", "K", ":m '<-2<CR>gv=gv", opts)

map("n", "<C-d>", "<C-d>zz", opts)
map("n", "<C-u>", "<C-u>zz", opts)
map("n", "n", "nzzzv", opts)
map("n", "N", "Nzzzv", opts)

-- в mini.files берём запись под курсором, иначе — файл текущего буфера
local function current_path()
	if vim.bo.filetype == "minifiles" then
		local entry = require("mini.files").get_fs_entry()
		return entry and entry.path
	end

	local buf = vim.api.nvim_buf_get_name(0)
	return buf ~= "" and buf or nil
end

map("n", "<leader>o", function()
	local path = current_path()
	if not path or not vim.uv.fs_stat(path) then
		vim.notify("Нет файла на диске", vim.log.levels.WARN)
		return
	end

	vim.system({ "open", "-R", path }, {}, function(result)
		if result.code ~= 0 then
			vim.schedule(function()
				vim.notify("open -R: " .. (result.stderr or ""), vim.log.levels.ERROR)
			end)
			return
		end

		-- open -R не всегда выводит Finder на передний план
		vim.system({ "osascript", "-e", 'tell application "Finder" to activate' })
	end)
end, { desc = "Reveal in Finder" })
