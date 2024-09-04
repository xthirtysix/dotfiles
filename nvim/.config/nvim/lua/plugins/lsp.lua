---@diagnostic disable: undefined-global
return {
    {
        'neovim/nvim-lspconfig',
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
                    'tsserver',
                    'volar',
                    -- go
                    'gopls',
                    -- salesforce,
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
                [1] = 'tsserver',
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
            local mason_registry = require 'mason-registry'
            local vue_language_server_path = mason_registry.get_package('vue-language-server'):get_install_path()

            lspconfig.tsserver.setup {
                init_options = {
                    plugins = {
                        {
                            name = '@vue/typescript-plugin',
                            location = '/opt/homebrew/lib/node_modules/@vue/typescript-plugin',
                            languages = {
                                'javascript',
                                'typescript',
                                'vue',
                            },
                        },
                    },
                },
                filetypes = {
                    'javascript',
                    'typescript',
                    'vue',
                },
            }

            local util = require 'lspconfig.util'

            local volar_init_options = {
                typescript = {
                    tsdk = '',
                },
            }

            local function get_typescript_server_path(root_dir)
                local project_root = util.find_node_modules_ancestor(root_dir)
                return project_root and (util.path.join(project_root, 'node_modules', 'typescript', 'lib')) or ''
            end

            -- No need to set `hybridMode` to `true` as it's the default value
            lspconfig.volar.setup {
                cmd = { 'vue-language-server', '--stdio' },
                filetypes = { 'vue' },
                root_dir = util.root_pattern 'package.json',
                init_options = volar_init_options,
                on_new_config = function(new_config, new_root_dir)
                    if
                        new_config.init_options
                        and new_config.init_options.typescript
                        and new_config.init_options.typescript.tsdk == ''
                    then
                        new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
                    end
                end,
            }

            -- Highlight CSS colors
            require('nvim-highlight-colors').setup {
                render = 'background', -- or 'foreground' or 'first_column'
                enable_named_colors = true,
            }

            vim.keymap.set('n', '<leader>dd', vim.diagnostic.open_float, opts)
            vim.keymap.set('n', '<leader>ld', vim.lsp.buf.definition, { desc = 'Go to definition' })
            vim.keymap.set('n', '<leader>lD', vim.lsp.buf.declaration, { desc = 'Go to declaration' })
            vim.keymap.set(
                { 'n' },
                '<leader>ca',
                vim.lsp.buf.code_action,
                { desc = 'Display modal window with code action' }
            )
            vim.keymap.set(
                'n',
                '<leader>li',
                vim.lsp.buf.hover,
                { desc = 'Display info about keyword under the cursor' }
            )
        end,
    },
}
