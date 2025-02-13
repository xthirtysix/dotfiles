return {
    'numToStr/Comment.nvim',
    opts = {},
    config = function()
        require('Comment').setup {
            ignore = '^$',
        }
    end,
}
