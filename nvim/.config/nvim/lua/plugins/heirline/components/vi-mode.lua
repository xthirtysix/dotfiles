local ViMode = {
    static = {
        mode_names = { -- change the strings if you like it vvvvverbose!
            n = '',
            no = 'N?',
            nov = 'N?',
            noV = 'N?',
            ['no\22'] = 'N?',
            niI = 'Ni',
            niR = 'Nr',
            niV = 'Nv',
            nt = 'Nt',
            v = '',
            vs = 'Vs',
            V = 'V_',
            Vs = 'Vs',
            ['\22'] = '󱤢',
            ['\22s'] = '󱤢',
            s = 'Select',
            S = 'S_',
            ['\19'] = '^S',
            i = '󱇧',
            ic = 'Ic',
            ix = 'Ix',
            R = 'R',
            Rc = 'Rc',
            Rx = 'Rx',
            Rv = 'Rv',
            Rvc = 'Rv',
            Rvx = 'Rv',
            c = '',
            cv = 'Ex',
            r = '...',
            rm = 'M',
            ['r?'] = '?',
            ['!'] = '!',
            t = '',
        },
    },

    update = {
        'ModeChanged',
        pattern = '*:*',
        callback = vim.schedule_wrap(function()
            vim.cmd 'redrawstatus'
        end),
    },

    flexible = 1000,
    {
        {
            provider = '',
            hl = function(self)
                return { fg = self.color_bright }
            end,
        },
        {
            provider = function(self)
                return '%2(' .. self.mode_names[self.mode] .. '%) '
            end,
            hl = function(self)
                return { fg = self.color_dark, bg = self.color_bright }
            end,
        },
        {
            provider = function()
                return '█'
            end,
            hl = function(self)
                return { fg = self.color_bright, bg = self.color_dark }
            end,
        },
        {
            provider = ' ',
            hl = function(self)
                return { fg = self.color_dark, bg = self.color_bright }
            end,
        },
    },
}

return ViMode

