local Git = {
    condition = function()
        local path = vim.loop.cwd() .. '/.git'
        local ok = vim.loop.fs_stat(path)
        if not ok then
            return false
        end
        return true
    end,

    on_click = {
        callback = function()
            vim.defer_fn(function()
                vim.cmd 'lua Snacks.picker.git_branches()'
            end, 100)
        end,
        name = 'heirline_git',
    },

    update = {
        'DirChanged',
        'BufWritePost',
        'BufEnter',
        'ModeChanged',
    },

    init = function(self)
        local head_message = vim.fn.system 'git rev-parse --abbrev-ref HEAD'
        if string.find(head_message, 'fatal') then
            self.current_dir_head = vim.fn.system 'git branch --show-current' .. ' (no origin)'
        else
            self.current_dir_head = head_message
        end
    end,

    flexible = 2,
    {
        {
            provider = function()
                return '█'
            end,
            hl = function(self)
                return { fg = self.color_bright }
            end,
        },
        {
            provider = function(self)
                return '' .. ' ' .. self.current_dir_head:gsub('%\n', '')
            end,
            hl = function(self)
                return { fg = self.color_dark, bg = self.color_bright }
            end,
        },
        {
            provider = '█',
            hl = function(self)
                return { fg = self.color_bright, bg = self.color_dark }
            end,
        },
    },
}

return Git

