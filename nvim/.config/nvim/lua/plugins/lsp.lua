---@diagnostic disable: undefined-global
return {
    {
        'neovim/nvim-lspconfig',
        keys = {
            { '<leader>lh', vim.diagnostic.open_float, desc = 'Diagnostics' },
            { '<leader>ld', vim.lsp.buf.definition, desc = 'Go to definition' },
            { '<leader>lD', vim.lsp.buf.declaration, desc = 'Go to declaration' },
            { '<leader>la', vim.lsp.buf.code_action, desc = 'Code actions' },
            { '<leader>li', vim.lsp.buf.hover, desc = 'Info under cursor' },
        },
        dependencies = {
            {
                'williamboman/mason.nvim',
                config = true,
                opts = {},
            },
            { 'williamboman/mason-lspconfig.nvim' },
            { 'brenoprata10/nvim-highlight-colors' },
        },
        lazy = false,
        config = function()
            local mason_lspconfig = require 'mason-lspconfig'

            mason_lspconfig.setup {
                ensure_installed = {
                    -- lua
                    'lua_ls',
                    -- js/ts
                    'ts_ls',
                    'volar',
                    -- go
                    'gopls',
                    -- salesforce,
                    'apex_ls',
                },
                auto_install = true,
            }

            -- require('cmp').setup {
            --     sources = {
            --         { name = 'nvim_lsp' },
            --     },
            -- }

            -- local capabilities = require('cmp_nvim_lsp').default_capabilities()

            local lspconfig = require 'lspconfig'

            local lsps = {
                [1] = 'ts_ls',
                [2] = 'cssls',
                [3] = 'html',
                [4] = 'lwc_ls',
                [5] = 'gopls',
                [6] = 'lua_ls',
                [7] = 'volar',
                [8] = 'apex_ls',
            }

            -- setup LSP autocompletions
            for _, lsp in pairs(lsps) do
                lspconfig[lsp].setup {
                    capabilities = capabilities,
                }
            end

            -- Salesforce
            lspconfig.apex_ls.setup {
                apex_enable_semantic_errors = false,
                apex_enable_completion_statistics = false,
                filetypes = { 'apex' },
                root_dir = lspconfig.util.root_pattern 'sfdx-project.json',
                on_attach = on_attach,
                capabilities = capabilities,
            }

            -- typescript
            local function organize_imports()
                local params = {
                    command = '_typescript.organizeImports',
                    arguments = { vim.api.nvim_buf_get_name(0) },
                    title = '',
                }
                vim.lsp.buf.execute_command(params)
            end

            local vue_language_server_path = '/path/to/@vue/language-server'

            lspconfig.volar.setup {}
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
            }

            -- Highlight CSS colors
            require('nvim-highlight-colors').setup {
                render = 'background', -- or 'foreground' or 'first_column'
                enable_named_colors = true,
            }
        end,
    },
}
