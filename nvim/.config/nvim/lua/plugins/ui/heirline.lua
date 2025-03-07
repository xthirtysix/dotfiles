return {
    'rebelot/heirline.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
        'EdenEast/nightfox.nvim',
    },
    event = 'VeryLazy',
    opts = {},
    enabled = true,
    config = function(_, opts)
        local heirline = require 'heirline'
        local conditions = require 'heirline.conditions'
        local utils = require 'heirline.utils'
        heirline.setup(opts)

        -- --------------------------------------------------
        -- Colors
        -- --------------------------------------------------
        local Color = require 'nightfox.lib.color'
        local base = Color.from_hex '#303030'

        local function fade(color, amount)
            amount = amount or 0.05
            return base:blend(Color.from_hex(color), amount):to_css()
        end

        local colors = {
            -- bg/fg
            bright_bg = utils.get_highlight('Folded').bg,
            bright_fg = utils.get_highlight('Folded').fg,
            -- colors
            red = utils.get_highlight('DiagnosticError').fg,
            dark_red = utils.get_highlight('DiffDelete').bg,
            green = utils.get_highlight('String').fg,
            blue = utils.get_highlight('Function').fg,
            gray = utils.get_highlight('NonText').fg,
            orange = utils.get_highlight('Constant').fg,
            purple = utils.get_highlight('Statement').fg,
            cyan = utils.get_highlight('Special').fg,
            -- diagnostics
            diag_warn = utils.get_highlight('DiagnosticWarn').fg or 'yellow',
            diag_error = utils.get_highlight('DiagnosticError').fg or 'red',
            diag_hint = utils.get_highlight('DiagnosticHint').fg or 'cyan',
            diag_info = utils.get_highlight('DiagnosticInfo').fg or 'green',
            -- git
            git_del = utils.get_highlight('diffDeleted').fg or 'red',
            git_add = utils.get_highlight('diffAdded').fg or 'green',
            git_change = utils.get_highlight('diffChanged').fg or 'yellow',
        }

        local mode_colors = {
            n = colors.blue,
            i = colors.green,
            v = colors.purple,
            V = colors.purple,
            ['\22'] = colors.purple,
            c = colors.orange,
            s = colors.cyan,
            S = colors.cyan,
            ['\19'] = colors.cyan,
            R = colors.orange,
            r = colors.orange,
            ['!'] = colors.red,
            t = colors.cyan,
        }

        -- --------------------------------------------------
        -- Mode
        -- --------------------------------------------------
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

        -- --------------------------------------------------
        -- File Name
        -- --------------------------------------------------
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

                local filepath = vim.api.nvim_buf_get_name(0)
                self.filename = vim.fn.fnamemodify(filepath, ':t')
                local extension = vim.fn.fnamemodify(self.filename, ':e')
                self.icon, self.icon_color =
                    require('nvim-web-devicons').get_icon_color(self.filename, extension, { default = true })
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
                        return { fg = self.color_bright }
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

        -- -- --------------------------------------------------
        -- Git branch
        -- --------------------------------------------------
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

        -- -- --------------------------------------------------
        -- GitDiff
        -- --------------------------------------------------
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

        -- --------------------------------------------------
        -- Diagnostic
        -- --------------------------------------------------
        local Diagnostics = {

            condition = conditions.has_diagnostics,

            static = {
                error_icon = vim.fn.sign_getdefined('DiagnosticSignError')[1].text,
                warn_icon = vim.fn.sign_getdefined('DiagnosticSignWarn')[1].text,
                info_icon = vim.fn.sign_getdefined('DiagnosticSignInfo')[1].text,
                hint_icon = vim.fn.sign_getdefined('DiagnosticSignHint')[1].text,
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
                    provider = '',
                    hl = { fg = colors.bright_fg },
                },
            },
        }

        -- --------------------------------------------------
        -- Codeium
        -- --------------------------------------------------
        local NeoCodeium = {
            static = {
                symbols = {
                    status = {
                        [0] = '󰚩 ', -- Enabled
                        [1] = '󱚧 ', -- Disabled Globally
                        [2] = '󱙻 ', -- Disabled for Buffer
                        [3] = '󱙺 ', -- Disabled for Buffer filetype
                        [4] = '󱙺 ', -- Disabled for Buffer with enabled function
                        [5] = '󱚠 ', -- Disabled for Buffer encoding
                    },
                    server_status = {
                        [0] = '󰣺 ', -- Connected
                        [1] = '󰣻 ', -- Connecting
                        [2] = '󰣽 ', -- Disconnected
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
                    provider = '█',
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
                    provider = '',
                    hl = function(self)
                        return { bg = self.color_dark }
                    end,
                },
            },
        }

        -- --------------------------------------------------
        -- LSP
        -- --------------------------------------------------
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
                    provider = '█',
                    hl = function(self)
                        return { fg = self.color_dark }
                    end,
                },
                {
                    provider = function()
                        local names = {}
                        for _, server in pairs(vim.lsp.get_active_clients { bufnr = 0 }) do
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

        -- --------------------------------------------------
        -- Linter
        -- --------------------------------------------------
        local LinterActive = {
            condition = function(self)
                if require('lazy.core.config').plugins['nvim-lint']._.loaded then
                    self.linters = require('lint').get_running()
                    if #self.linters ~= 0 then
                        return true
                    else
                        return false
                    end
                else
                    return false
                end
            end,

            flexible = 30,

            {
                {
                    condition = conditions.lsp_attached,
                    provider = '',
                    hl = function(self)
                        return { bg = self.color_dark }
                    end,
                },
                {
                    condition = function()
                        return not conditions.lsp_attached
                    end,
                    provider = '█',
                    hl = function(self)
                        return { fg = self.color_dark }
                    end,
                },
                {
                    provider = '█',
                    hl = function(self)
                        return { fg = self.color_dark }
                    end,
                },
                {
                    provider = function(self)
                        return '󱉶 ' .. table.concat(self.linters, ', ')
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

        -- --------------------------------------------------
        -- Nav
        -- --------------------------------------------------
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
                sbar = { '🭶', '🭷', '🭸', '🭹', '🭺', '🭻' },
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

        -- --------------------------------------------------
        -- Spacings
        -- --------------------------------------------------
        local Align = { provider = '%=' }
        local Space = { provider = ' ' }

        -- --------------------------------------------------
        -- Init functions
        -- --------------------------------------------------
        local function initMode(self)
            self.mode = vim.fn.mode(1)
        end

        local function initHasGit(self)
            local path = vim.loop.cwd() .. '/.git'
            self.has_git = vim.loop.fs_stat(path)
        end

        local function initColors(self)
            self.color_dark = fade(mode_colors[vim.fn.mode(1):sub(1, 1)])
            self.color_bright = mode_colors[vim.fn.mode(1):sub(1, 1)]
        end

        -- --------------------------------------------------
        -- Plugin init
        -- --------------------------------------------------
        require('heirline').setup {
            statusline = {
                init = function(self)
                    initMode(self)
                    initColors(self)
                    initHasGit(self)
                end,
                hl = { bg = 'none' },
                Space,
                ViMode,
                FileName,
                Git,
                GitDiff,
                Diagnostics,
                Align,
                Align,
                Align,
                Align,
                Space,
                NeoCodeium,
                LSPActive,
                LinterActive,
                Ruler,
                Space,
            },
            opts = {
                colors = colors,
            },
        }
    end,
}
