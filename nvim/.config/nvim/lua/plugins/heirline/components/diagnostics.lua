local conditions = require 'heirline.conditions'

local Diagnostics = {
    condition = conditions.has_diagnostics,

    static = {
        error_icon = (vim.fn.sign_getdefined('DiagnosticSignError')[1] or {}).text or ' ',
        warn_icon = (vim.fn.sign_getdefined('DiagnosticSignWarn')[1] or {}).text or ' ',
        info_icon = (vim.fn.sign_getdefined('DiagnosticSignInfo')[1] or {}).text or ' ',
        hint_icon = (vim.fn.sign_getdefined('DiagnosticSignHint')[1] or {}).text or ' ',
    },

    init = function(self)
        self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
        self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
        self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
        self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
        self.has_issues = (self.errors and self.errors > 0)
            or (self.warnings and self.warnings > 0)
            or (self.hints and self.hints > 0)
            or (self.info and self.info > 0)
    end,

    update = { 'DiagnosticChanged', 'BufEnter' },

    flexible = 1,
    {
        {
            provider = function(self)
                -- 0 is just another output, we can decide to print it or not!
                return self.errors > 0 and (self.error_icon .. self.errors .. ' ')
            end,
            hl = { fg = 'diag_error' },
        },
        {
            provider = function(self)
                return self.warnings > 0 and (self.warn_icon .. self.warnings .. ' ')
            end,
            hl = { fg = 'diag_warn' },
        },
        {
            provider = function(self)
                return self.info > 0 and (self.info_icon .. self.info .. ' ')
            end,
            hl = { fg = 'diag_info' },
        },
        {
            provider = function(self)
                return self.hints > 0 and (self.hint_icon .. self.hints)
            end,
            hl = { fg = 'diag_hint' },
        },
        {
            condition = function(self)
                return self.has_issues
            end,
            provider = '',
            hl = { fg = 'bright_fg' },
        },
    },
}

return Diagnostics
