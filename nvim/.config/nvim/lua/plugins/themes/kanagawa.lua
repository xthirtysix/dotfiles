return {
    'rebelot/kanagawa.nvim',
    lazy = false,
    priority = 1000,
    enabled = true,
    config = function()
        local theme = require 'kanagawa'
        theme.setup {
            compile = true,
            undercurl = true,
            commentStyle = { italic = true },
            keywordStyle = { italic = true },
            statementStyle = { bold = true },
            transparent = true,
            dimInactive = true,
            terminalColors = false,
            theme = 'wave',
            background = {
                dark = 'wave',
                light = 'lotus',
            },
        }
        vim.cmd 'colorscheme kanagawa'
    end,
}
