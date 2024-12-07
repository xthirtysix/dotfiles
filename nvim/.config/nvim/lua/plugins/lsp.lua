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
                    'gopls',
                    'apex_ls',
                },
                auto_install = true,
            }

            require('cmp').setup {
                sources = {
                    { name = 'nvim_lsp' },
                },
            }

            local capabilities = require('cmp_nvim_lsp').default_capabilities()

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

            -- Setup LSP autocompletions and apply border styles
            for _, lsp in pairs(lsps) do
                lspconfig[lsp].setup {
                    capabilities = capabilities,
                    handlers = handlers,
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
                handlers = handlers,
            }

            -- Highlight CSS colors
            require('nvim-highlight-colors').setup {
                render = 'background', -- or 'foreground' or 'first_column'
                enable_named_colors = true,
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
