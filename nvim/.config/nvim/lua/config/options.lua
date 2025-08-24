local options = {
    -- signcolumn / line numbers
    number = true,
    relativenumber = true,
    signcolumn = 'yes',

    -- colors and ui
    cursorline = true,
    background = 'dark',
    winborder = 'rounded',

    -- text formatting
    wrap = true,
    breakindent = true,

    -- tabstops
    expandtab = true,
    tabstop = 4,
    softtabstop = 4,
    shiftwidth = 4,

    -- chars
    list = false,
    listchars = {
        tab = ' ->',
        trail = '~',
        extends = '>',
        precedes = '<',
        space = '·',
    },

    -- search
    ignorecase = true,
    smartcase = true,

    -- undo history
    undofile = true,
}

for index, value in pairs(options) do
    vim.opt[index] = value
end

