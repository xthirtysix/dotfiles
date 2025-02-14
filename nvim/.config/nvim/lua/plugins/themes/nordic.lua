return {
    'AlexvZyl/nordic.nvim',
    lazy = false,
    priority = 1000,
    enabled = false,
    config = function()
        local theme = require 'nordic'
        theme.setup {
            transparent = {
                bg = true,
                float = true,
            },
            bright_border = true,
            noice = {
                style = 'flat',
            }
        }
        theme.load()
    end,
}
