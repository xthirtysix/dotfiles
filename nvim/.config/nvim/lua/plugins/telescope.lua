return {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.5',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('plenary.filetype').add_file 'sf_type'
        end,
    },
    {
        'nvim-telescope/telescope-ui-select.nvim',
        config = function()
            require('telescope').setup {
                defaults = {
                    file_ignore_patterns = {
                        'node_modules',
                        '__lwr_cache__',
                    },
                },
                extensions = {
                    ['ui-select'] = {
                        require('telescope.themes').get_dropdown {},
                    },
                },
            }

            require('telescope').load_extension 'ui-select'
        end,
    },
}
