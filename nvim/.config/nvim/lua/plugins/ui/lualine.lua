return {
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            { 'nvim-tree/nvim-web-devicons' },
            { 'arkav/lualine-lsp-progress' },
        },
        config = function()
            local function diff_source()
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                    return {
                        added = gitsigns.added,
                        modified = gitsigns.changed,
                        removed = gitsigns.removed,
                    }
                end
            end

            require 'harpoon'
            require('lualine').setup {
                options = {
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
                                    return [[󱤢]]
                                elseif mode:lower() == 'insert' then
                                    return [[󱇧]]
                                elseif mode:lower() == 'command' then
                                    return [[]]
                                else
                                    return mode
                                end
                            end,
                            separator = { left = '  ', right = '' },
                        },
                    },
                    lualine_b = {
                        { 'b:gitsigns_head', icon = '' },
                        {
                            'diff',
                            source = diff_source,
                            symbols = {
                                added = ' ',
                                modified = ' ',
                                removed = ' ',
                            },
                        },
                        'diagnostics',
                    },
                    lualine_c = {
                        {
                            'harpoon2',
                            icon = ' ',
                            indicators = { 'q', 'w', 'e', 'r' },
                            active_indicators = { 'Q', 'W', 'E', 'R' },
                            color = { fg = '#9ccfd8' },
                            color_active = { fg = '#eb6f92' },
                            no_harpoon = '...',
                        },
                    },
                    lualine_x = {
                        {
                            'lsp_progress',
                            separators = {
                                component = ' ',
                                progress = ' | ',
                                message = { pre = '(', post = ')' },
                                percentage = { pre = '', post = '%% ' },
                                title = { pre = '', post = ': ' },
                                lsp_client_name = { pre = '[', post = ']' },
                                spinner = { pre = '', post = '' },
                            },
                            display_components = { 'lsp_client_name', 'spinner', { 'percentage' } },
                            timer = { progress_enddelay = 500, spinner = 1000, lsp_client_name_enddelay = 1000 },
                            spinner_symbols = { '🌑 ', '🌒 ', '🌓 ', '🌔 ', '🌕 ', '🌖 ', '🌗 ', '🌘 ' },
                        },
                        {
                            'filename',
                            path = 1,
                            symbols = {
                                modified = '󱇨 ', -- Text to show when the file is modified.
                                readonly = '󱀰 ', -- Text to show when the file is non-modifiable or readonly.
                                unnamed = '󱀶 ', -- Text to show for unnamed buffers.
                                newfile = '󰻭 ', -- Text to show for newly created file before first write
                            },
                        },
                    },
                    lualine_y = {
                        {
                            'filetype',
                            separator = { left = '', right = ' ' },
                        },
                    },
                    lualine_z = {
                        { 'location', icon = '', separator = { right = ' ' } },
                    },
                },
                extensions = {
                    'lazy',
                    'mason',
                    'trouble',
                },
            }
        end,
    },
}
