require('which-key').add {
    -- Format
    {
        '<leader>e',
        icon = { icon = '', hl = 'WhichKeyNormal' },
    },
    {
        '<leader>f',
        icon = { icon = '󰉶', hl = 'WhichKeyNormal' },
    },
    {
        '<leader><space>',
        function()
            Snacks.picker.smart {
                title = '󰥨 Find files',
            }
        end,
        desc = 'Find files',
        icon = { icon = '󰥨', hl = 'WhichKeyNormal' },
    },
    {
        '<leader>/',
        function()
            Snacks.picker.grep { title = '󰺯 Find in files ' }
        end,
        desc = 'Find in files',
        icon = { icon = '󰺯', hl = 'WhichKeyNormal' },
    },
    -- LSP
    {
        '<leader>l',
        group = 'LSP',
        icon = { icon = '', hl = 'WhichKeyGroup' },
    },
    {
        '<leader>ld',
        desc = 'Definition',
        icon = { icon = '󰫧', hl = 'WhichKeyNormal' },
    },
    {
        '<leader>lt',
        desc = 'Type definition',
        icon = { icon = '', hl = 'WhichKeyNormal' },
    },
    {
        '<leader>lf',
        icon = { icon = '󰉶', hl = 'WhichKeyNormal' },
    },
    {
        '<leader>le',
        icon = { icon = '󰱺', hl = 'WhichKeyNormal' },
    },
    {
        '<leader>la',
        icon = { icon = '󱐋', hl = 'WhichKeyNormal' },
    },
    {
        '<leader>li',
        icon = { icon = '󰋼', hl = 'WhichKeyNormal' },
    },
    {
        '<leader>lh',
        icon = { icon = '', hl = 'WhichKeyNormal' },
    },
    -- LSP go to
    {
        'gd',
        function()
            Snacks.picker.lsp_definitions()
        end,
        desc = 'Go to Definition',
        icon = { icon = '󰈞', hl = 'WhichKeyNormal' },
    },
    {
        'gD',
        function()
            Snacks.picker.lsp_declarations()
        end,
        desc = 'Go to Declaration',
        icon = { icon = '󰈞', hl = 'WhichKeyNormal' },
    },
    {
        'gr',
        function()
            Snacks.picker.lsp_references()
        end,
        nowait = true,
        desc = 'Go to References',
        icon = { icon = '', hl = 'WhichKeyNormal' },
    },
    {
        'gI',
        function()
            Snacks.picker.lsp_implementations()
        end,
        desc = 'Go to Implementation',
        icon = { icon = '󰈞', hl = 'WhichKeyNormal' },
    },
    {
        'gy',
        function()
            Snacks.picker.lsp_type_definitions()
        end,
        desc = 'Goto T[y]pe Definition',
        icon = { icon = '󰈞', hl = 'WhichKeyNormal' },
    },
    -- Harpoon
    {
        '<leader>h',
        group = 'Harpoon',
        icon = { icon = '↽', hl = 'WhichKeyGroup' },
    },
    {
        '<leader>hl',
        icon = { icon = '󰸕', hl = 'WhichKeyNormal' },
    },
    {
        '<leader>ha',
        icon = { icon = '󰃅', hl = 'WhichKeyNormal' },
    },
    {
        '<leader>hd',
        icon = { icon = '󰃆', hl = 'WhichKeyNormal' },
    },
    {
        '<leader>hn',
        icon = { icon = '󰒭', hl = 'WhichKeyNormal' },
    },
    {
        '<leader>hp',
        icon = { icon = '󰒮', hl = 'WhichKeyNormal' },
    },
    {
        '<leader>hq',
        icon = { icon = '󰸖', hl = 'WhichKeyNormal' },
    },
    {
        '<leader>hw',
        icon = { icon = '󰸖', hl = 'WhichKeyNormal' },
    },
    {
        '<leader>he',
        icon = { icon = '󰸖', hl = 'WhichKeyNormal' },
    },
    {
        '<leader>hr',
        icon = { icon = '󰸖', hl = 'WhichKeyNormal' },
    },
    -- PX to REM
    {
        '<leader>p',
        group = 'px->rem',
        icon = { icon = '', hl = 'WhichKeyGroup' },
    },
    {
        '<leader>px',
        icon = { icon = '', hl = 'WhichKeyNormal' },
    },
    {
        '<leader>pc',
        icon = { icon = '', hl = 'WhichKeyNormal' },
    },
    -- Trouble
    {
        '<leader>x',
        group = 'Trouble',
        icon = { icon = '', hl = 'WhichKeyGroup' },
    },
    {
        '<leader>xx',
        '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
        desc = 'Current buffer Diagnostics ',
    },
    {
        '<leader>xX',
        '<cmd>Trouble diagnostics toggle<cr>',
        desc = 'Folder diagnostics ',
    },
    {
        '<leader>xs',
        '<cmd>Trouble symbols toggle focus=false<cr>',
        desc = 'Symbols',
    },
    {
        '<leader>xl',
        '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
        desc = 'LSP Definitions / references / ...',
    },
    {
        '<leader>xL',
        '<cmd>Trouble loclist toggle<cr>',
        desc = 'Location List',
    },
    {
        '<leader>xQ',
        '<cmd>Trouble qflist toggle<cr>',
        desc = 'Quickfix List',
    },
    -- HOP
    {
        '<leader>j',
        group = 'hop to...',
        icon = { icon = '󰑮', hl = 'WhichKeyGroup' },
    },
    {
        '<leader>jj',
        '<cmd>HopPattern<CR>',
        desc = '...word',
        icon = { icon = '', hl = 'WhWhichKeyNormal' },
    },
    {
        '<leader>jl',
        '<cmd>HopLineStart<CR>',
        desc = '...line',
        icon = { icon = '', hl = 'WhWhichKeyNormal' },
    },
    -- GIT
    {
        '<leader>g',
        group = 'git',
        icon = { icon = '', hl = 'WhichKeyGroup' },
    },
    {
        '<leader>gg',
        function()
            Snacks.lazygit.open()
        end,
        desc = 'Lazygit',
        icon = { icon = '', hl = 'WhichKeyNormal' },
    },
    {
        '<leader>gs',
        function()
            Snacks.picker.git_status()
        end,
        desc = 'Git Status',
        icon = { icon = '', hl = 'WhichKeyNormal' },
    },
    {
        '<leader>gd',
        function()
            Snacks.picker.git_diff()
        end,
        desc = 'Git Diff',
        icon = { icon = '', hl = 'WhichKeyNormal' },
    },
    {
        '<leader>gl',
        function()
            Snacks.picker.git_log()
        end,
        desc = 'Git Log',
        icon = { icon = '', hl = 'WhichKeyNormal' },
    },
    {
        '<leader>gL',
        function()
            Snacks.picker.git_log_line()
        end,
        desc = 'Git Log Line',
        icon = { icon = '', hl = 'WhichKeyNormal' },
    },
    {
        '<leader>gf',
        function()
            Snacks.picker.git_log_file()
        end,
        desc = 'Git Log File',
        icon = { icon = '', hl = 'WhichKeyNormal' },
    },
    {

        '<leader>gj',
        function()
            local gitsigns = require 'gitsigns'
            if vim.wo.diff then
                vim.cmd.normal { ']c', bang = true }
            else
                gitsigns.nav_hunk 'next'
            end
        end,
        desc = 'Git next change',
        icon = { icon = '', hl = 'WhichKeyNormal' },
    },
    {
        '<leader>gk',
        function()
            local gitsigns = require 'gitsigns'
            if vim.wo.diff then
                vim.cmd.normal { '[c', bang = true }
            else
                gitsigns.nav_hunk 'prev'
            end
        end,
        desc = 'Git prev change',
        icon = { icon = '', hl = 'WhichKeyNormal' },
    },
}
