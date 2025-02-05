return {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
        -- animations lib
        animate = {},
        -- lazygit integration
        lazygit = {},
        -- indeint higlihgt
        indent = {
            scope = {
                enabled = true,
                hl = 'Comment',
            },
            chunk = {
                enabled = false,
                hl = 'Comment',
                char = {
                    corner_top = '╭',
                    corner_bottom = '╰',
                    horizontal = '─',
                    vertical = '│',
                    arrow = '─',
                },
            },
        },
        picker = {}, -- picker
        scroll = {}, -- smooth scrolling
    },
}
