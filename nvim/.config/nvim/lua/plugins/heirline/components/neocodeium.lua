local NeoCodeium = {
    static = {
        symbols = {
            status = {
                [0] = ' ', -- Enabled
                [1] = ' ', -- Disabled Globally
                [2] = ' ', -- Disabled for Buffer
                [3] = ' ', -- Disabled for Buffer filetype
                [4] = ' ', -- Disabled for Buffer with enabled function
                [5] = ' ', -- Disabled for Buffer encoding
            },
            server_status = {
                [0] = ' ', -- Connected
                [1] = ' ', -- Connecting
                [2] = ' ', -- Disconnected
            },
        },
    },
    update = {
        'User',
        pattern = { 'NeoCodeiumServer*', 'NeoCodeium*{En,Dis}abled' },
        callback = function()
            vim.cmd.redrawstatus()
        end,
    },
    {
        {
            provider = '',
            hl = function(self)
                return { fg = self.color_dark }
            end,
        },
        {
            provider = function(self)
                local symbols = self.symbols
                local status, server_status = require('neocodeium').get_status()
                return symbols.status[status] .. symbols.server_status[server_status] .. ' '
            end,
            hl = function(self)
                return { bg = self.color_dark }
            end,
        },
        {
            provider = '',
            hl = function(self)
                return { bg = self.color_dark }
            end,
        },
    },
}

return NeoCodeium

