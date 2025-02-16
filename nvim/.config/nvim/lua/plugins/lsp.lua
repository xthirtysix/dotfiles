---@diagnostic disable: undefined-global
return {
    {
        'nvimdev/lspsaga.nvim',
        config = function()
            require('lspsaga').setup {}
        end,
        dependencies = {
            'nvim-treesitter/nvim-treesitter', -- optional
            'nvim-tree/nvim-web-devicons', -- optional
        },
        keys = {
            { '<leader>ld', '<cmd>Lspsaga peek_definition<cr>', desc = 'Definition', mode = 'n' },
            { '<leader>lt', '<cmd>Lspsaga peek_type_definition<cr>', desc = 'Type definition', mode = 'n' },
            { '<leader>la', '<cmd>Lspsaga code_action<cr>', desc = 'Code actions' },
            { '<leader>lh', '<cmd>Lspsaga show_cursor_diagnostics<cr>', desc = 'Diagnostics' },
        },
    },
    {
        'neovim/nvim-lspconfig',
        keys = {
            { '<leader>ld', vim.lsp.buf.definition, desc = 'Go to definition' },
            { '<leader>lD', vim.lsp.buf.declaration, desc = 'Go to declaration' },
            { '<leader>li', vim.lsp.buf.hover, desc = 'Info under cursor' },
        },
        dependencies = {
            {
                'williamboman/mason.nvim',
                config = true,
                opts = {},
            },
            { 'williamboman/mason-lspconfig.nvim' },
            { 'saghen/blink.cmp' },
        },
        lazy = false,
        config = function()
            -- Specify how the border looks like
            local border = {
                { '┌', 'FloatBorder' },
                { '─', 'FloatBorder' },
                { '┐', 'FloatBorder' },
                { '│', 'FloatBorder' },
                { '┘', 'FloatBorder' },
                { '─', 'FloatBorder' },
                { '└', 'FloatBorder' },
                { '│', 'FloatBorder' },
            }

            -- Add the border on hover and on signature help popup window
            local handlers = {
                ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = border, max_width = 80 }),
                ['textDocument/signatureHelp'] = vim.lsp.with(
                    vim.lsp.handlers.signature_help,
                    { border = border, max_width = 80 }
                ),
            }

            -- Add border to the diagnostic popup window
            vim.diagnostic.config {
                virtual_text = {
                    prefix = '', -- Could be '●', '▎', 'x', '■', , 
                },
                float = { border = border, max_width = 80 },
            }

            local mason_lspconfig = require 'mason-lspconfig'

            mason_lspconfig.setup {
                ensure_installed = {
                    'lua_ls',
                    'ts_ls',
                    'volar',
                },
                auto_install = true,
            }

            local lspconfig = require 'lspconfig'

            local lsps = {
                [1] = 'ts_ls',
                [2] = 'cssls',
                [3] = 'html',
                [4] = 'lua_ls',
                [5] = 'volar',
            }

            -- Setup LSP autocompletions and apply border styles
            for _, lsp in pairs(lsps) do
                lspconfig[lsp].setup {
                    capabilities = require('blink.cmp').get_lsp_capabilities(lspconfig[lsp].capabilities),
                    handlers = handlers,
                }
            end

            -- Salesforce
            -- lspconfig.apex_ls.setup {
            --     apex_enable_semantic_errors = false,
            --     apex_enable_completion_statistics = false,
            --     filetypes = { 'apex' },
            --     root_dir = lspconfig.util.root_pattern 'sfdx-project.json',
            --     on_attach = on_attach,
            --     capabilities = capabilities,
            -- }

            -- Vue
            -- lspconfig.volar.setup {
            --     init_options = {
            --         vue = {
            --             hybridMode = false,
            --         },
            --     },
            --     settings = {
            --         typescript = {
            --             inlayHints = {
            --                 enumMemberValues = {
            --                     enabled = true,
            --                 },
            --                 functionLikeReturnTypes = {
            --                     enabled = true,
            --                 },
            --                 propertyDeclarationTypes = {
            --                     enabled = true,
            --                 },
            --                 parameterTypes = {
            --                     enabled = true,
            --                     suppressWhenArgumentMatchesName = true,
            --                 },
            --                 variableTypes = {
            --                     enabled = true,
            --                 },
            --             },
            --         },
            --     },
            -- }
            --
            -- Typescript
            lspconfig.ts_ls.setup {
                init_options = {
                    plugins = {
                        {
                            name = '@vue/typescript-plugin',
                            location = '/opt/homebrew/lib/node_modules/@vue/typescript-plugin/',
                            languages = { 'vue' },
                        },
                    },
                },
                filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
                settings = {
                    typescript = {
                        tsserver = {
                            useSyntaxServer = false,
                        },
                        inlayHints = {
                            includeInlayParameterNameHints = 'all',
                            includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                            includeInlayFunctionParameterTypeHints = true,
                            includeInlayVariableTypeHints = true,
                            includeInlayVariableTypeHintsWhenTypeMatchesName = true,
                            includeInlayPropertyDeclarationTypeHints = true,
                            includeInlayFunctionLikeReturnTypeHints = true,
                            includeInlayEnumMemberValueHints = true,
                        },
                    },
                },
                handlers = handlers,
            }

            -- SCSS
            lspconfig.somesass_ls.setup {
                filetypes = { 'sass', 'scss', 'less', 'css' },
            }

            -- Custom sidebar icons
            local signs = { Error = '󰚌 ', Warn = ' ', Hint = '󰍡 ', Info = ' ' }
            for type, icon in pairs(signs) do
                local hl = 'DiagnosticSign' .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end
        end,
    },
}
