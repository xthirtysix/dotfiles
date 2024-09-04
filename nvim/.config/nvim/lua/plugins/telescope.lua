return {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.5',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('plenary.filetype').add_file 'sf_type'

            local builtin = require 'telescope.builtin'

            vim.keymap.set(
                'n',
                '<leader>tf',
                builtin.find_files,
                { desc = 'Search for the files in current directory' }
            )

            vim.keymap.set('n', '<leader>tg', builtin.live_grep, { desc = 'Grep in current directory' })
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
