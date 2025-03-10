return {
    {
        'saghen/blink.cmp',
        dependencies = {
            { 'rafamadriz/friendly-snippets' },
            {
                'xzbdmw/colorful-menu.nvim',
                config = function()
                    require('colorful-menu').setup {
                        ls = {
                            ts_ls = {
                                extra_info_hl = '@comment',
                            },
                        },
                        fallback_highlight = '@variable',
                        max_width = 40,
                    }
                end,
            },
        },
        --     { 'saghen/blink.compat', opts = { enable_events = true } },
        --     {
        --         'Exafunction/codeium.nvim',
        --         config = function()
        --             require('codeium').setup {
        --                 virtual_text = {
        --                     enabled = true,
        --                     key_bindings = {
        --                         accept = '<Tab>',
        --                         next = '<M-]>',
        --                         prev = '<M-[>',
        --                         accept_word = false,
        --                         accept_line = false,
        --                         clear = false,
        --                     },
        --                 },
        --             }
        --         end,
        --     },
        -- },
        version = '*',
        opts = {
            keymap = {
                preset = 'default',
                ['<C-b>'] = { 'show', 'show_documentation', 'hide_documentation' },
                ['<C-e>'] = { 'hide', 'fallback' },
                ['<C-l>'] = { 'accept', 'fallback' },

                ['<Tab>'] = { 'snippet_forward', 'fallback' },
                ['<S-Tab>'] = { 'snippet_backward', 'fallback' },

                ['<C-k>'] = { 'select_prev', 'fallback' },
                ['<C-j>'] = { 'select_next', 'fallback' },
                ['<C-p>'] = { 'select_prev', 'fallback' },
                ['<C-n>'] = { 'select_next', 'fallback' },
                ['<C-d>'] = { 'scroll_documentation_up', 'fallback' },
                ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
            },

            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = 'mono',
            },

            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },

            signature = { enabled = true, window = { border = 'single' } },

            completion = {
                accept = {
                    -- Create an undo point when accepting a completion item
                    create_undo_point = true,
                    -- Experimental auto-brackets support
                    auto_brackets = {
                        -- Whether to auto-insert brackets for functions
                        enabled = true,
                        -- Default brackets to use for unknown languages
                        default_brackets = { '(', ')' },
                        -- Overrides the default blocked filetypes
                        override_brackets_for_filetypes = {},
                        -- Synchronously use the kind of the item to determine if brackets should be added
                        kind_resolution = {
                            enabled = true,
                            blocked_filetypes = { 'typescriptreact', 'javascriptreact', 'vue' },
                        },
                        -- Asynchronously use semantic token to determine if brackets should be added
                        semantic_token_resolution = {
                            enabled = true,
                            blocked_filetypes = { 'java' },
                            -- How long to wait for semantic tokens to return before assuming no brackets should be added
                            timeout_ms = 400,
                        },
                    },
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 500,
                    window = { border = 'single' },
                },
                menu = {
                    border = 'single',
                    draw = {
                        columns = { { 'label', gap = 2 }, { 'kind_icon', 'kind', gap = 1 } },
                        components = {
                            label = {
                                width = { fill = true, max = 40 },
                                text = function(ctx)
                                    return require('colorful-menu').blink_components_text(ctx)
                                end,
                                highlight = function(ctx)
                                    return require('colorful-menu').blink_components_highlight(ctx)
                                end,
                            },
                        },
                    },
                },
            },
        },
        opts_extend = { 'sources.default' },
    },
    {
        'monkoose/neocodeium',
        config = function()
            local neocodeium = require 'neocodeium'
            neocodeium.setup {
                show_label = false,
            }
            vim.keymap.set('i', '<Tab>', neocodeium.accept)
            vim.keymap.set('i', '<M-]>', function()
                require('neocodeium').cycle_or_complete()
            end)
            vim.keymap.set('i', '<M-[>', function()
                require('neocodeium').cycle_or_complete(-1)
            end)
        end,
    },
}
