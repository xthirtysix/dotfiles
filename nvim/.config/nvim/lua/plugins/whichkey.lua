return {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
        win = {
            width = 36,
            padding = { 1, 2 },
            border = 'single', -- none, single, double, shadow
        },
        layout = {
            width = { min = 100 },
        },
        sort = { 'manual', 'local', 'order', 'group', 'alphanum', 'mod' },
    },
    keys = {},
}
