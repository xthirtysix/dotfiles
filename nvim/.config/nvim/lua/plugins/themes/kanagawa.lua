return {
    'rebelot/kanagawa.nvim',
    lazy = false,
    priority = 1000,
    enabled = true,
    config = function()
        local theme = require 'kanagawa'
        theme.setup {
            compile = false,
            undercurl = true,
            commentStyle = { italic = true },
            keywordStyle = { italic = true },
            statementStyle = { bold = true },
            transparent = true,
            dimInactive = false,
            terminalColors = false,
            colors = {
                theme = {
                    all = {
                        ui = {
                            float = {
                                bg = 'none',
                                bg_gutter = 'none',
                            },
                        },
                    },
                },
            },
            background = {
                dark = 'wave',
                light = 'lotus',
            },
            overrides = function(colors)
                local colorScheme = colors.theme

                return {
                    NormalFloat = { bg = 'none' },
                    FloatBorder = { bg = 'none' },
                    FloatTitle = { bg = 'none' },
                    NormalDark = { fg = colorScheme.ui.fg_dim, bg = colorScheme.ui.bg_m3 },
                    LazyNormal = { bg = colorScheme.ui.bg_m3, fg = colorScheme.ui.fg_dim },
                    MasonNormal = { bg = colorScheme.ui.bg_m3, fg = colorScheme.ui.fg_dim },
                }
            end,
        }
        vim.cmd 'colorscheme kanagawa'
        vim.cmd 'highlight FloatBorder guibg=NONE'
    end,
}
