-- QoL plugins collection
return {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
        -- animations lib
        -- animate = {},
        -- lazygit integration
        lazygit = {},
        -- indeint higlihgt
        -- indent = {
        --     indent = {
        --         only_scope = true,
        --         only_current = true,
        --     },
        --     scope = {
        --         enabled = true,
        --         -- hl = 'Comment',
        --         hl = 'IndentBlanklineChar',
        --     },
        --     chunk = {
        --         enabled = false,
        --         hl = 'Comment',
        --         char = {
        --             corner_top = '╭',
        --             corner_bottom = '╰',
        --             horizontal = '─',
        --             vertical = '│',
        --             arrow = '─',
        --         },
        --     },
        --     animate = {
        --         style = 'out',
        --         duration = {
        --             step = 20, -- ms per step
        --             total = 1000, -- maximum duration
        --         },
        --     },
        -- },
        scroll = {}, -- smooth scrolling
        statuscolumn = {
            left = { 'mark', 'sign' }, -- priority of signs on the left (high to low)
            right = { 'fold', 'git' }, -- priority of signs on the right (high to low)
            folds = {
                open = false, -- show open fold icons
                git_hl = false, -- use Git Signs hl for fold icons
            },
            git = {
                -- patterns to match Git signs
                patterns = { 'GitSign', 'MiniDiffSign' },
            },
            refresh = 50, -- refresh at most every 50ms
        },
    },
    keys = {
        {
            ']]',
            function()
                Snacks.words.jump(vim.v.count1)
            end,
            desc = 'Next Reference',
            mode = { 'n', 't' },
        },
        {
            '[[',
            function()
                Snacks.words.jump(-vim.v.count1)
            end,
            desc = 'Prev Reference',
            mode = { 'n', 't' },
        },
    },
    init = function()
        vim.api.nvim_create_autocmd('User', {
            pattern = 'VeryLazy',
            callback = function()
                -- Setup some globals for debugging (lazy-loaded)
                _G.dd = function(...)
                    Snacks.debug.inspect(...)
                end
                _G.bt = function()
                    Snacks.debug.backtrace()
                end
                vim.print = _G.dd -- Override print to use snacks for `:=` command

                -- Create some toggle mappings spells
                Snacks.toggle.option('spell', { name = 'Spelling' }):map '<leader>us'
                Snacks.toggle.option('wrap', { name = 'Wrap' }):map '<leader>uw'
                Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map '<leader>uL'
                Snacks.toggle.diagnostics():map '<leader>ud'
                Snacks.toggle.line_number():map '<leader>ul'
                Snacks.toggle
                    .option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
                    :map '<leader>uc'
                Snacks.toggle.treesitter():map '<leader>uT'
                Snacks.toggle
                    .option('background', { off = 'light', on = 'dark', name = 'Dark Background' })
                    :map '<leader>ub'
                Snacks.toggle.inlay_hints():map '<leader>uh'
                Snacks.toggle.indent():map '<leader>ug'
                Snacks.toggle.dim():map '<leader>uD'
            end,
        })
    end,
}
