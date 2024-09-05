return {
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('lualine').setup {
                options = {
                    theme = 'kanagawa',
                    component_separators = { left = '', right = '' },
                    section_separators = { left = '', right = '' },
                },
                extensions = {
                    'lazy',
                    'mason',
                    'nvim-tree',
                },
            }
        end,
    },
}
