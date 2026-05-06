-- QoL plugins collection
return {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
        animate = { enabled = true },
        scroll = { enabled = true },
        bigfile = { enabled = false },
        dashboard = {
            enabled = true,
            formats = {
                key = function(item)
                    return { { '[', hl = 'special' }, { item.key, hl = 'key' }, { ']', hl = 'special' } }
                end,
            },
            sections = {
                {
                    section = 'terminal',
                    cmd = 'fortune -s | cowsay',
                    hl = 'header',
                    padding = 1,
                    indent = 8,
                },
                { title = 'MRU',            padding = 1 },
                { section = 'recent_files', limit = 8,                            padding = 1 },
                { title = 'MRU ',           file = vim.fn.fnamemodify('.', ':~'), padding = 1 },
                { section = 'recent_files', cwd = true,                           limit = 8,  padding = 1 },
                { title = 'Sessions',       padding = 1 },
                { section = 'projects',     padding = 1 },
                { title = 'Bookmarks',      padding = 1 },
                { section = 'keys' },
            },
        },
        explorer = { enabled = false },
        indent = { enabled = false },
        input = { enabled = false },
        picker = {
            enabled = true,
            formatters = {
                file = {
                    truncate = 40,
                },
            },
        },
        notifier = { enabled = false },
        quickfile = { enabled = false },
        scope = { enabled = false },
        words = { enabled = true },
        lazygit = {},
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
        -- Pickers
        {
            '<leader><space>',
            function()
                Snacks.picker.smart()
            end,
            desc = 'Smart Find Files',
        },

        -- { "<leader><space>", function() Snacks.picker.files() end,                 desc = "Find Files" },
        {
            '<leader>,',
            function()
                Snacks.picker.buffers()
            end,
            desc = 'Buffers',
        },
        {
            '<leader>/',
            function()
                Snacks.picker.grep()
            end,
            desc = 'Grep',
        },
        {
            '<leader>fb',
            function()
                Snacks.picker.grep({ buffers = true })
            end,
            desc = 'Grep buffer',
        },
        {
            '<leader>gb',
            function()
                Snacks.picker.git_branches()
            end,
            desc = 'Git Branches',
        },
        {
            '<leader>gd',
            function()
                Snacks.picker.git_diff()
            end,
            desc = 'Git Diff (Hunks)',
        },
        -- LSP
        {
            'gd',
            function()
                Snacks.picker.lsp_definitions()
            end,
            desc = 'Goto Definition',
        },
        {
            'gD',
            function()
                Snacks.picker.lsp_declarations()
            end,
            desc = 'Goto Declaration',
        },
        {
            'gr',
            function()
                Snacks.picker.lsp_references()
            end,
            nowait = true,
            desc = 'References',
        },
        {
            'gI',
            function()
                Snacks.picker.lsp_implementations()
            end,
            desc = 'Goto Implementation',
        },
        {
            'gy',
            function()
                Snacks.picker.lsp_type_definitions()
            end,
            desc = 'Goto T[y]pe Definition',
        },
        {
            '<leader>ss',
            function()
                Snacks.picker.lsp_symbols()
            end,
            desc = 'LSP Symbols',
        },
        {
            '<leader>sS',
            function()
                Snacks.picker.lsp_workspace_symbols()
            end,
            desc = 'LSP Workspace Symbols',
        },
        {
            '<leader>sd',
            function()
                Snacks.picker.diagnostics({
                    layout = {
                        preset = 'vertical',
                        layout = { width = 0.9 },
                    },
                })
            end,
            desc = 'Diagnostics',
        },
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
                Snacks.toggle.option('spell', { name = 'Spelling' }):map('<leader>us')
                Snacks.toggle.option('wrap', { name = 'Wrap' }):map('<leader>uw')
                Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map('<leader>uL')
                Snacks.toggle.diagnostics():map('<leader>ud')
                Snacks.toggle.line_number():map('<leader>ul')
                Snacks.toggle
                    .option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
                    :map('<leader>uc')
                Snacks.toggle.treesitter():map('<leader>uT')
                Snacks.toggle
                    .option('background', { off = 'light', on = 'dark', name = 'Dark Background' })
                    :map('<leader>ub')
                Snacks.toggle.inlay_hints():map('<leader>uh')
                Snacks.toggle.indent():map('<leader>ug')
                Snacks.toggle.dim():map('<leader>uD')
            end,
        })
    end,
}
