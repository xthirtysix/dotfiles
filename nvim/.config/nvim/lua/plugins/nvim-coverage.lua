return {
    'andythigpen/nvim-coverage',
    dependencies = 'nvim-lua/plenary.nvim',
    config = function()
        require('coverage').setup()
    end,
    keys = {
        {
            '<leader>tc',
            function()
                require('coverage').load(true)
            end,
            desc = 'Load coverage',
        },
        {
            '<leader>tC',
            function()
                require('coverage').clear()
            end,
            desc = 'Clear coverage',
        },
    },
}
