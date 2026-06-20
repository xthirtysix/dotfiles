return {
    'sainnhe/sonokai',
    lazy = false,
    priority = 1000,
    config = function()
        vim.g.sonokai_style = 'andromeda'
        vim.g.sonokai_enable_italic = true
        vim.g.sonokai_better_performance = 1

        vim.g.sonokai_colors_override = {
            red = { '#F92672', '161' },
            green = { '#A6E22E', '148' },
            yellow = { '#E6DB74', '186' },
            orange = { '#FD971F', '208' },
            blue = { '#66D9EF', '81' },
            purple = { '#AE81FF', '141' },
        }

        vim.cmd.colorscheme('sonokai')
    end,
}
