return {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
        require('dashboard').setup {
            config = {
                theme = 'doom',
                week_header = {
                    enable = true, --boolean use a week header
                },
            },
        }
    end,
    dependencies = { { 'nvim-tree/nvim-web-devicons' } },
}
