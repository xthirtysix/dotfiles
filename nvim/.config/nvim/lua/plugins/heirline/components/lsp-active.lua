local conditions = require 'heirline.conditions'

local LSPActive = {
    condition = conditions.lsp_attached,

    on_click = {
        callback = function()
            vim.defer_fn(function()
                vim.cmd 'LspInfo'
            end, 100)
        end,
        name = 'heirline_LSP',
    },

    update = {
        'LspAttach',
        'LspDetach',
        'DirChanged',
        'BufWritePost',
        'BufEnter',
        'ModeChanged',
    },

    flexible = 20,

    {

        {
            provider = '█',
            hl = function(self)
                return { fg = self.color_dark }
            end,
        },
        {
            provider = function()
                local names = {}
                for _, server in pairs(vim.lsp.get_clients{ bufnr = 0 }) do
                    table.insert(names, server.name)
                end
                return ' ' .. table.concat(names, ', ')
            end,
            hl = function(self)
                return { bg = self.color_dark }
            end,
        },
        {
            provider = '█',
            hl = function(self)
                return { fg = self.color_dark }
            end,
        },
    },
}

return LSPActive

