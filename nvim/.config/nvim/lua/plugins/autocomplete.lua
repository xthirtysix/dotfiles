return {
    'saghen/blink.cmp',
    dependencies = {
        { 'rafamadriz/friendly-snippets' },
        {
            'xzbdmw/colorful-menu.nvim',
            config = function()
                require('colorful-menu').setup {
                    ft = {
                        typescript = {
                            enabled = { 'typescript', 'typescriptreact', 'typescript.tsx', 'vue' },
                        },
                    },
                }
            end,
        },
    },
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

        signature = { enabled = true },

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
            },
            menu = {
                draw = {
                    columns = { { 'label', 'label_description', gap = 5 }, { 'kind_icon', 'kind', gap = 2 } },
                    components = {
                        label = {
                            width = { fill = true, max = 70 },
                            text = function(ctx)
                                local highlights_info = require('colorful-menu').highlights(ctx.item, vim.bo.filetype)
                                if highlights_info ~= nil then
                                    return highlights_info.text
                                else
                                    return ctx.label
                                end
                            end,
                            highlight = function(ctx)
                                local highlights_info = require('colorful-menu').highlights(ctx.item, vim.bo.filetype)
                                local highlights = {}
                                if highlights_info ~= nil then
                                    for _, info in ipairs(highlights_info.highlights) do
                                        table.insert(highlights, {
                                            info.range[1],
                                            info.range[2],
                                            group = ctx.deprecated and 'BlinkCmpLabelDeprecated' or info[1],
                                        })
                                    end
                                end
                                for _, idx in ipairs(ctx.label_matched_indices) do
                                    table.insert(highlights, { idx, idx + 1, group = 'BlinkCmpLabelMatch' })
                                end
                                return highlights
                            end,
                        },
                    },
                },
            },
        },
    },
    opts_extend = { 'sources.default' },
}
