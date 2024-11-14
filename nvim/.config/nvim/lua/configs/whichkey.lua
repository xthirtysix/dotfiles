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
    -- LSP
    {
        '<leader>l',
        group = 'LSP',
        icon = { icon = '', hl = 'WhichKeyGroup' },
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
    {
        '<leader>ld',
        icon = { icon = '', hl = 'WhichKeyNormal' },
    },
    {
        '<leader>lD',
        icon = { icon = '', hl = 'WhichKeyNormal' },
    },
    -- Telescope
    {
        '<leader>t',
        group = 'Telescope',
        icon = { icon = '', hl = 'WhichKeyGroup' },
    },
    {
        '<leader>tf',
        icon = { icon = '', hl = 'WhichKeyNormal' },
    },
    {
        '<leader>tg',
        icon = { icon = '', hl = 'WhichKeyNormal' },
    },
    -- Harpoon
    {
        '<leader>h',
        group = 'Harpoon',
        icon = { icon = '↽', hl = 'WhichKeyGroup' },
    },
    {
        '<leader>hl',
        icon = { icon = '', hl = 'WhichKeyNormal' },
    },
    {
        '<leader>ha',
        icon = { icon = '', hl = 'WhichKeyNormal' },
    },
    {
        '<leader>hr',
        icon = { icon = '', hl = 'WhichKeyNormal' },
    },
    {
        '<leader>hn',
        icon = { icon = '󰒭', hl = 'WhichKeyNormal' },
    },
    {
        '<leader>hp',
        icon = { icon = '󰒮', hl = 'WhichKeyNormal' },
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
}
