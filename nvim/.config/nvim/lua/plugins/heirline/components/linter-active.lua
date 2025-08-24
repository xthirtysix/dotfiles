local conditions = require 'heirline.conditions'

local LinterActive = {
    condition = function(self)
        -- if require('lazy.core.config').plugins['nvim-lint']._.loaded then
        --     self.linters = require('lint').get_running()
        --     if #self.linters ~= 0 then
        --         return true
        --     else
        --         return false
        --     end
        -- else
        --     return false
        -- end
    end,

    flexible = 30,

    {
        {
            condition = conditions.lsp_attached,
            provider = '',
            hl = function(self)
                return { bg = self.color_dark }
            end,
        },
        {
            condition = function()
                return not conditions.lsp_attached
            end,
            provider = '',
            hl = function(self)
                return { fg = self.color_dark }
            end,
        },
        {
            provider = '',
            hl = function(self)
                return { fg = self.color_dark }
            end,
        },
        {
            provider = function(self)
                return ' ' .. table.concat(self.linters, ', ')
            end,
            hl = function(self)
                return { bg = self.color_dark }
            end,
        },
        {
            provider = '',
            hl = function(self)
                return { fg = self.color_dark }
            end,
        },
    },
}

return LinterActive

