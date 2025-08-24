local conditions = require 'heirline.conditions'

local GitDiff = {
    condition = conditions.is_git_repo,

    init = function(self)
        self.status_dict = vim.b.gitsigns_status_dict
        self.has_changes = (self.status_dict.added and self.status_dict.added ~= 0)
            or (self.status_dict.removed and self.status_dict.removed ~= 0)
            or (self.status_dict.changed and self.status_dict.changed ~= 0)
    end,

    update = {
        'BufEnter',
        'ModeChanged',
    },

    flexible = 1,
    {
        {
            condition = function(self)
                return self.has_changes
            end,
            provider = '█',
            hl = function(self)
                return { fg = self.color_dark }
            end,
        },
        {
            provider = function(self)
                local count = self.status_dict.added or 0
                return count > 0 and (' ' .. count .. ' ')
            end,
            hl = function(self)
                return { fg = 'git_add', bg = self.color_dark }
            end,
        },
        {
            provider = function(self)
                local count = self.status_dict.removed or 0
                return count > 0 and (' ' .. count .. ' ')
            end,
            hl = function(self)
                return { fg = 'git_del', bg = self.color_dark }
            end,
        },
        {
            provider = function(self)
                local count = self.status_dict.changed or 0
                return count > 0 and (' ' .. count .. ' ')
            end,
            hl = function(self)
                return { fg = 'git_change', bg = self.color_dark }
            end,
        },
        {
            provider = '',
            hl = function(self)
                return { fg = self.color_dark }
            end,
        },
    },
}

return GitDiff

