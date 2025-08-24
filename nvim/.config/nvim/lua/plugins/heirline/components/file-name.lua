local conditions = require 'heirline.conditions'

local FileName = {
    update = {
        'DirChanged',
        'BufWritePost',
        'BufEnter',
        'ModeChanged',
    },

    init = function(self)
        local path = vim.loop.cwd() .. '/.git'
        self.has_git = vim.loop.fs_stat(path)

        self.filename = vim.api.nvim_buf_get_name(0)
        local filename = self.filename

        -- Заменяем пути /Users/{username} на ~
        if filename:match("^/Users/[^/]+") then
            filename = filename:gsub("^/Users/[^/]+", "~")
        end

        -- self.filename = vim.fn.fnamemodify(filepath, ':.')
        if filename == "" then return "[No Name]" end
        if not conditions.width_percent_below(#filename, 0.25) then
            filename = vim.fn.pathshorten(filename)
        end
        local extension = vim.fn.fnamemodify(filename, ':e')
        self.icon, self.icon_color =
            require('nvim-web-devicons').get_icon_color(filename, extension, { default = true })

        -- Обновляем self.filename с измененным путем
        self.filename = filename
    end,

    flexible = 2,
    {
        {
            provider = function(self)
                return self.icon and (self.icon .. ' ' .. self.filename)
            end,
            hl = function(self)
                return { bg = self.color_bright, fg = self.color_dark }
            end,
        },
        {
            condition = function(self)
                return not self.has_git
            end,

            provider = '',
            hl = function(self)
                return { fg = self.color_bright, bg = self.color_dark }
            end,
        },
        {
            condition = function(self)
                return self.has_git
            end,
            provider = '',
            hl = function(self)
                return { fg = self.color_dark, bg = self.color_bright }
            end,
        },
    },
}

return FileName
