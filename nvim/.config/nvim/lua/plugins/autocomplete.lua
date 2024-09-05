return {
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'L3MON4D3/LuaSnip',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'onsails/lspkind.nvim', -- icons describing autocomplete entity
            'rafamadriz/friendly-snippets',
        },
        config = function()
            require('luasnip.loaders.from_vscode').lazy_load()

            local cmp = require 'cmp'

            cmp.setup {
                completion = {
                    completeopt = 'menu,menuone,preview,noselect',
                },
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert {
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm { select = true },
                },
                sources = cmp.config.sources {
                    --                    { name = 'nvim_lsp' },
                    { name = 'luasnip' }, -- For luasnip users.
                    { name = 'buffer' },
                    { name = 'path' },
                },
                formatting = {
                    format = require('lspkind').cmp_format {
                        maxwidth = 60,
                        show_labelDetails = true,
                        ellipsis_char = '...',
                    },
                },
            }
        end,
    },
}