vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.termguicolors = true
opt.showmode = false
opt.laststatus = 3
opt.winborder = "rounded"

require("core.ui2")

opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.smartindent = true
opt.breakindent = true
opt.wrap = false

opt.foldlevel = 99
opt.foldlevelstart = 99

opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true
opt.inccommand = "split"

opt.confirm = true

opt.splitright = true
opt.splitbelow = true

opt.undofile = true
opt.swapfile = false
opt.backup = false

opt.completeopt = {
	"menu",
	"menuone",
	"noselect",
}

opt.scrolloff = 8
opt.sidescrolloff = 8

local function escape_langmap(str)
	return vim.fn.escape(str, [[;,."|\]])
end

local en = [[`qwertyuiop[]asdfghjkl;'zxcvbnm]]
local ru = [[ёйцукенгшщзхъфывапролджэячсмить]]
local en_shift = [[~QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>]]
local ru_shift = [[ËЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ]]

opt.langmap = table.concat({
	escape_langmap(ru_shift) .. ";" .. escape_langmap(en_shift),
	escape_langmap(ru) .. ";" .. escape_langmap(en),
}, ",")

vim.schedule(function()
	opt.clipboard = "unnamedplus"
end)
