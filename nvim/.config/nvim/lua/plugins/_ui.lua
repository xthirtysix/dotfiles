return {
    -- Rosepine colorscheme
    {
        'rose-pine/neovim',
        name = 'rose-pine',
        config = function()
            require('rose-pine').setup {
                variant = 'main', -- auto, main, moon, or dawn
                dark_variant = 'main', -- main, moon, or dawn
                dim_inactive_windows = false,
                extend_background_behind_borders = true,

                enable = {
                    terminal = true,
                    migrations = true, -- Handle deprecated options automatically
                },

                styles = {
                    bold = true,
                    italic = true,
                    transparency = true,
                },

                groups = {
                    border = 'muted',
                    link = 'iris',
                    panel = 'surface',

                    error = 'love',
                    hint = 'iris',
                    info = 'foam',
                    note = 'pine',
                    todo = 'rose',
                    warn = 'gold',

                    git_add = 'foam',
                    git_change = 'rose',
                    git_delete = 'love',
                    git_dirty = 'rose',
                    git_ignore = 'muted',
                    git_merge = 'iris',
                    git_rename = 'pine',
                    git_stage = 'iris',
                    git_text = 'rose',
                    git_untracked = 'subtle',

                    h1 = 'iris',
                    h2 = 'foam',
                    h3 = 'rose',
                    h4 = 'gold',
                    h5 = 'pine',
                    h6 = 'foam',
                },

                highlight_groups = {
                    Whitespace = { fg = 'highlight_med' },
                    VertSplit = { fg = 'muted', bg = 'muted' },
                },
            }

            vim.cmd 'colorscheme rose-pine'
        end,
    },
    -- popup, cmdline, messages UI replacement
    {
        'folke/noice.nvim',
        event = 'VeryLazy',
        dependencies = {
            'MunifTanjim/nui.nvim',
            'rcarriga/nvim-notify',
        },
        config = function()
            require('telescope').load_extension 'noice'
            require('notify').setup {
                background_colour = '#1f1d2e',
            }
            require('noice').setup {
                lsp = {
                    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                    override = {
                        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
                        ['vim.lsp.util.stylize_markdown'] = true,
                        ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
                    },
                },
                -- you can enable a preset for easier configuration
                presets = {
                    bottom_search = true, -- use a classic bottom cmdline for search
                    command_palette = true, -- position the cmdline and popupmenu together
                    long_message_to_split = true, -- long messages will be sent to a split
                    inc_rename = false, -- enables an input dialog for inc-rename.nvim
                    lsp_doc_border = false, -- add a border to hover docs and signature help
                },
            }
        end,
    },
    -- smooth scrolling
    {
        'declancm/cinnamon.nvim',
        version = '*', -- use latest release
        opts = {
            -- change default options here
            keymaps = {
                basic = true,
                extra = true,
            },
            options = { mode = 'window' },
        },
    },
}
