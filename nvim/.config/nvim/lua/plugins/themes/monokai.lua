return {
    'polirritmico/monokai-nightasty.nvim',
    lazy = false,
    priority = 1000,
    enabled = false,
    opts = {
        dark_style_background = '#2b2d3a',
        light_style_background = 'default',
    },
    config = function(_, opts)
        vim.o.background = 'dark'
        require('monokai-nightasty').load(opts)
    end,
}
