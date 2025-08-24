local Ruler = {
    update = {
        'DirChanged',
        'BufWritePost',
        'BufEnter',
        'ModeChanged',
        'CursorMoved',
        'WinScrolled',
    },

    static = {
        sbar = { '', '', '', '', '', '' },
    },

    flexible = 1,
    {

        {
            provider = '',
            hl = function(self)
                return { fg = self.color_bright, bg = self.color_dark }
            end,
        },
        {
            -- %l = current line number
            -- %L = number of lines in the buffer
            -- %c = column number
            -- %P = percentage through file of displayed window
            provider = '%7(%l/%3L%):%2c',
            hl = function(self)
                return { fg = self.color_dark, bg = self.color_bright }
            end,
        },
        {
            provider = '█',
            hl = function(self)
                return { fg = self.color_bright, bg = self.color_dark }
            end,
        },
        {
            provider = function(self)
                local curr_line = vim.api.nvim_win_get_cursor(0)[1]
                local lines = vim.api.nvim_buf_line_count(0)
                local i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
                return string.rep(self.sbar[i], 2)
            end,
            hl = function(self)
                return { fg = self.color_dark, bg = self.color_bright }
            end,
        },
        {
            provider = '',
            hl = function(self)
                return { fg = self.color_bright }
            end,
        },
    },
}

return Ruler

