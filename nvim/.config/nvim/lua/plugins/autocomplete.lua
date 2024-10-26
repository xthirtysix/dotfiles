return {
    'saghen/blink.cmp',
    lazy = false, -- lazy loading handled internally
    -- optional: provides snippets for the snippet source
    dependencies = 'rafamadriz/friendly-snippets',

    -- use a release tag to download pre-built binaries
    version = 'v0.*',

    opts = {
        highlight = {
            -- sets the fallback highlight groups to nvim-cmp's highlight groups
            -- useful for when your theme doesn't support blink.cmp
            -- will be removed in a future release, assuming themes add support
            use_nvim_cmp_as_default = true,
        },
        -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'normal',

        -- experimental auto-brackets support
        accept = { auto_brackets = { enabled = true } },

        -- experimental signature help support
        trigger = { signature_help = { enabled = true } },
    },
}

-- Keep in case blink.cmp sucks

-- return {
--     {
--         'hrsh7th/nvim-cmp',
--         dependencies = {
--             'L3MON4D3/LuaSnip',
--             'hrsh7th/cmp-nvim-lsp',
--             'hrsh7th/cmp-buffer',
--             'hrsh7th/cmp-path',
--             'onsails/lspkind.nvim', -- icons describing autocomplete entity
--             'rafamadriz/friendly-snippets',
--         },
--         config = function()
--             require('luasnip.loaders.from_vscode').lazy_load()
--
--             local cmp = require 'cmp'
--
--             cmp.setup {
--                 completion = {
--                     completeopt = 'menu,menuone,preview,noselect',
--                 },
--                 snippet = {
--                     expand = function(args)
--                         require('luasnip').lsp_expand(args.body)
--                     end,
--                 },
--                 mapping = cmp.mapping.preset.insert {
--                     ['<C-b>'] = cmp.mapping.scroll_docs(-4),
--                     ['<C-f>'] = cmp.mapping.scroll_docs(4),
--                     ['<C-Space>'] = cmp.mapping.complete(),
--                     ['<C-e>'] = cmp.mapping.abort(),
--                     ['<CR>'] = cmp.mapping.confirm { select = true },
--                 },
--                 sources = cmp.config.sources {
--                     --                    { name = 'nvim_lsp' },
--                     { name = 'luasnip' }, -- For luasnip users.
--                     { name = 'buffer' },
--                     { name = 'path' },
--                 },
--                 formatting = {
--                     format = require('lspkind').cmp_format {
--                         maxwidth = 60,
--                         show_labelDetails = true,
--                         ellipsis_char = '...',
--                     },
--                 },
--             }
--         end,
--     },
-- }
