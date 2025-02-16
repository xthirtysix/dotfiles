return {
    'EdenEast/nightfox.nvim',
    config = function()
        require('nightfox').setup {
            options = {
                transparent = true,
            },
        }
        require('lualine').setup {
            options = { theme = 'nordfox' },
        }
        vim.cmd 'colorscheme nordfox'
    end,
}
