vim.g.mapleader = ' '

local options = {
    background = 'dark',
    filetype = 'on',
    signcolumn = 'yes',
    tabstop = 4,
    shiftwidth = 4,
    expandtab = true,
    number = true,
    relativenumber = true,
    list = true,
    listchars = {
        tab = ' ->',
        trail = '~',
        extends = '>',
        precedes = '<',
        -- space = '·',
    },
}

for index, value in pairs(options) do
    vim.opt[index] = value
end
