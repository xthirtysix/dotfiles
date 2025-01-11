return {
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('lualine').setup {
                options = {
                    theme = 'rosepine',
                    component_separators = { left = '', right = '' },
                    section_separators = { left = '', right = '' },
                },
                sections = {
                    lualine_a = {
                        {
                            'mode',
                            fmt = function(mode)
                                if mode:lower() == 'normal' then
                                    return [[]]
                                elseif mode:lower() == 'visual' then
                                    return [[]]
                                elseif mode:lower() == 'v-block' then
                                    return [[]]
                                elseif mode:lower() == 'insert' then
                                    return [[]]
                                elseif mode:lower() == 'command' then
                                    return [[]]
                                else
                                    return mode
                                end
                            end,
                        },
                    },
                    lualine_b = { { 'branch', icon = '' }, 'diff', 'diagnostics' },
                    lualine_c = { 'filename' },
                    lualine_x = {
                        {
                            'harpoon2',
                            icon = '⇁ ',
                            indicators = { 'q', 'w', 'e', 'r' },
                            active_indicators = { 'Q', 'W', 'E', 'R' },
                            color = {  fg = '#9ccfd8' },
                            color_active = { fg = '#eb6f92' },
                            _separator = ' ',
                            no_harpoon = '...',
                        },
                    },
                    lualine_y = {
                        {
                            'filetype',
                            separator = { left = '', right = ' ' },
                        },
                    },
                    lualine_z = { { 'location' } },
                },
                extensions = {
                    'lazy',
                    'mason',
                },
            }
        end,
    },
}
