return {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
        win = {
            width = 50,
        },
        padding = { 2, 2 },
        border = 2,
        layout = {
            width = { min = 100 },
        },
        sort = { 'manual', 'local', 'order', 'group', 'alphanum', 'mod' },
    },
    keys = {},
}
