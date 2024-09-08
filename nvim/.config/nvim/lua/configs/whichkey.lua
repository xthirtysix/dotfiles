require('which-key').add {
    -- Format
    {
        '<leader>e',
        desc = 'Explorer',
        icon = { icon = '', hl = 'WhichKeyNormal' },
    },
    {
        '<leader>f',
        desc = 'Format code',
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
        desc = 'Format with null_ls',
        icon = { icon = '󰉶', hl = 'WhichKeyNormal' },
    },
    {
        '<leader>la',
        desc = 'Code actions',
        icon = { icon = '󱐋', hl = 'WhichKeyNormal' },
    },
    {
        '<leader>li',
        desc = 'Info under cursor',
        icon = { icon = '󰋼', hl = 'WhichKeyNormal' },
    },
    {
        '<leader>lh',
        desc = 'Open disgnostic popup',
        icon = { icon = '', hl = 'WhichKeyNormal' },
    },
    {
        '<leader>ld',
        desc = 'Go to definition',
        icon = { icon = '', hl = 'WhichKeyNormal' },
    },
    {
        '<leader>lD',
        desc = 'Go to declaration',
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
        desc = 'Search by file name',
        icon = { icon = '', hl = 'WhichKeyNormal' },
    },
    {
        '<leader>tg',
        desc = 'Grep by code',
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
        desc = 'List items',
        icon = { icon = '', hl = 'WhichKeyNormal' },
    },
    {
        '<leader>ha',
        desc = 'Add item',
        icon = { icon = '', hl = 'WhichKeyNormal' },
    },
    {
        '<leader>hr',
        desc = 'Remove item',
        icon = { icon = '', hl = 'WhichKeyNormal' },
    },
    {
        '<leader>hn',
        desc = 'Next item',
        icon = { icon = '󰒭', hl = 'WhichKeyNormal' },
    },
    {
        '<leader>hp',
        desc = 'Previous item',
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
        desc = 'Convert line to rem',
        icon = { icon = '', hl = 'WhichKeyNormal' },
    },
    {
        '<leader>pc',
        desc = 'Convert to rem under cursor',
        icon = { icon = '', hl = 'WhichKeyNormal' },
    },
}
