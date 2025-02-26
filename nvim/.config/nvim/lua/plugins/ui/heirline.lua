return {
    'rebelot/heirline.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
        'Zeioth/heirline-components.nvim',
    },
    event = 'VeryLazy',
    opts = {},
    enabled = true,
    config = function(_, opts)
        local heirline = require 'heirline'
        local conditions = require 'heirline.conditions'
        local utils = require 'heirline.utils'
        local heirline_components = require 'heirline-components.all'
        heirline.load_colors(heirline_components.hl.get_colors())
        heirline.setup(opts)

        local Align = { provider = '%=' }
        local Space = { provider = ' ' }

        -- --------------------------------------------------
        -- Colors
        -- --------------------------------------------------
        local colors = {
            bright_bg = utils.get_highlight('Folded').bg,
            bright_fg = utils.get_highlight('Folded').fg,
            red = utils.get_highlight('DiagnosticError').fg,
            dark_red = utils.get_highlight('DiffDelete').bg,
            green = utils.get_highlight('String').fg,
            blue = utils.get_highlight('Function').fg,
            gray = utils.get_highlight('NonText').fg,
            orange = utils.get_highlight('Constant').fg,
            purple = utils.get_highlight('Statement').fg,
            cyan = utils.get_highlight('Special').fg,
            diag_warn = utils.get_highlight('DiagnosticWarn').fg,
            diag_error = utils.get_highlight('DiagnosticError').fg,
            diag_hint = utils.get_highlight('DiagnosticHint').fg,
            diag_info = utils.get_highlight('DiagnosticInfo').fg,
            git_del = utils.get_highlight('diffDeleted').fg,
            git_add = utils.get_highlight('diffAdded').fg,
            git_change = utils.get_highlight('diffChanged').fg,
        }

        -- --------------------------------------------------
        -- Mode
        -- --------------------------------------------------

        local ViMode = {
            init = function(self)
                self.mode = vim.fn.mode(1)
            end,
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
                    t = 'Terminal',
                },
                mode_colors = {
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
                    t = colors.gray,
                },
            },
            update = {
                'ModeChanged',
                pattern = '*:*',
                callback = vim.schedule_wrap(function()
                    vim.cmd 'redrawstatus'
                end),
            },
            -- Return
            utils.surround({ '', '' }, 'none', {
                flexible = 1000,
                {
                    {
                        provider = function()
                            return ''
                        end,
                        hl = function(self)
                            return { fg = self.mode_colors[self.mode:sub(1, 1)] }
                        end,
                    },
                    {
                        provider = function(self)
                            return '%2(' .. self.mode_names[self.mode] .. '%) '
                        end,
                        hl = function(self)
                            return { fg = 'black', bg = self.mode_colors[self.mode:sub(1, 1)], bold = true }
                        end,
                    },
                    {
                        provider = function()
                            return ''
                        end,
                        hl = function(self)
                            return { fg = self.mode_colors[self.mode:sub(1, 1)], bg = 'lightblue' }
                        end,
                    },
                },
            }),
        }

        -- --------------------------------------------------
        -- Git
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
            update = { 'DirChanged', 'BufWritePost', 'BufEnter' },

            init = function(self)
                local head_message = vim.fn.system 'git rev-parse --abbrev-ref HEAD'
                if string.find(head_message, 'fatal') then
                    self.current_dir_head = vim.fn.system 'git branch --show-current' .. ' (no origin)'
                else
                    self.current_dir_head = head_message
                end
            end,

            utils.surround({ '█', '' }, 'lightblue', {
                hl = { fg = 'black' },
                flexible = 2,
                {
                    provider = function(self)
                        return '' .. ' ' .. self.current_dir_head:gsub('%\n', '')
                    end,
                },
                {
                    provider = function(self)
                        return '' .. ' ' .. self.current_dir_head:gsub('%\n', ''):sub(1, 10)
                    end,
                },
                {
                    provider = function()
                        return ''
                    end,
                },
            }),
        }

        -- -- --------------------------------------------------
        -- GitDiff
        -- --------------------------------------------------
        -- local GitDiff = heirline_components.component.git_diff { surround = { color = 'none' } }
        local GitDiff = {
            condition = conditions.is_git_repo,

            init = function(self)
                self.status_dict = vim.b.gitsigns_status_dict
                self.has_changes = (self.status_dict.added and self.status_dict.added ~= 0)
                    or (self.status_dict.removed and self.status_dict.removed ~= 0)
                    or (self.status_dict.changed and self.status_dict.changed ~= 0)
            end,

            utils.surround({ '', '' }, 'none', {
                hl = { bg = 'none', fg = 'orange' },
                flexible = 1,
                {
                    {
                        condition = function(self)
                            return self.has_changes
                        end,
                        provider = ' ',
                    },
                    {
                        provider = function(self)
                            local count = self.status_dict.added or 0
                            return count > 0 and (' ' .. count .. ' ')
                        end,
                        hl = { fg = 'git_add' },
                    },
                    {
                        provider = function(self)
                            local count = self.status_dict.removed or 0
                            return count > 0 and (' ' .. count .. ' ')
                        end,
                        hl = { fg = 'git_del' },
                    },
                    {
                        provider = function(self)
                            local count = self.status_dict.changed or 0
                            return count > 0 and (' ' .. count .. ' ')
                        end,
                        hl = { fg = 'git_change' },
                    },
                    {
                        condition = function(self)
                            return self.has_changes
                        end,
                        provider = '',
                        hl = { fg = colors.bright_fg },
                    },
                },
            }),
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

            utils.surround({ ' ', '' }, 'none', {
                hl = { bg = 'none', fg = 'orange' },
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
            }),
        }
        -- --------------------------------------------------
        -- LSP
        -- --------------------------------------------------

        local LSPActive = {
            condition = conditions.lsp_attached,
            update = { 'LspAttach', 'LspDetach' },
            on_click = {
                callback = function()
                    vim.defer_fn(function()
                        vim.cmd 'LspInfo'
                    end, 100)
                end,
                name = 'heirline_LSP',
            },
            utils.surround({ '', '' }, 'green', {
                hl = { fg = 'black' },
                flexible = 20,
                {
                    provider = function()
                        local names = {}
                        for _, server in pairs(vim.lsp.get_active_clients { bufnr = 0 }) do
                            table.insert(names, server.name)
                        end
                        return ' ' .. table.concat(names, ', ')
                    end,
                },
                {
                    provider = function()
                        local names = {}
                        for _, server in pairs(vim.lsp.get_active_clients { bufnr = 0 }) do
                            table.insert(names, server.name:sub(1, 2))
                        end
                        return ' ' .. table.concat(names, ', ')
                    end,
                },
                {
                    provider = function()
                        return ' '
                    end,
                },
            }),
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
            utils.surround({ '', '' }, 'orange', {
                hl = { fg = 'black' },
                flexible = 30,
                {
                    provider = function(self)
                        return '󱉶 ' .. table.concat(self.linters, ', ')
                    end,
                },
                {
                    provider = function(self)
                        local shortened = {}
                        for i, linter in ipairs(self.linters) do
                            shortened[i] = linter:sub(1, 2)
                        end
                        return '󱉶 ' .. table.concat(shortened, ', ')
                    end,
                },
                {
                    provider = function()
                        return '󱉶'
                    end,
                },
            }),
        }

        -- --------------------------------------------------
        -- Lazy
        -- --------------------------------------------------

        local Lazy = {
            condition = require('lazy.status').has_updates,
            update = { 'User', pattern = 'LazyUpdate' },
            on_click = {
                callback = function()
                    vim.defer_fn(function()
                        vim.cmd 'Lazy'
                    end, 100)
                end,
                name = 'update_plugins',
            },
            utils.surround({ '', '' }, 'lightblue', {
                hl = { fg = 'black' },
                flexible = 1,
                {
                    provider = function()
                        return require('lazy.status').updates()
                    end,
                },
                {
                    provider = '',
                },
            }),
        }

        -- --------------------------------------------------
        -- Filetype
        -- --------------------------------------------------
        local FileType = heirline_components.component.file_info {
            filetype = false,
            filename = {},
            file_modified = false,
            surround = { color = 'none' },
        }

        -- --------------------------------------------------
        -- Nav
        -- --------------------------------------------------
        local Nav = heirline_components.component.nav { surround = { color = 'none', hl = { fg = colors.cyan } } }

        -- --------------------------------------------------
        -- Plugin init
        -- --------------------------------------------------
        -- local GitSeparator = SeparatorRight('lightblue', utils.get_highlight('Directory').fg)

        require('heirline').setup {
            statusline = {
                hl = { bg = 'none' },
                Space,
                ViMode,
                Git,
                GitDiff,
                Diagnostics,
                FileType,
                Align,
                Lazy,
                Align,
                Align,
                Align,
                Space,
                LSPActive,
                LinterActive,
                Nav,
                heirline_components.component.M,
            },
            opts = {
                colors = colors,
            },
        }
    end,
}
