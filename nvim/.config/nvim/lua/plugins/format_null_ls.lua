return {
    'nvimtools/none-ls.nvim',
    dependencies = { 'davidmh/cspell.nvim' },
    config = function()
        local null_ls = require 'null-ls'

        null_ls.setup {
            sources = {
                -- JS/TS
                null_ls.builtins.formatting.prettier.with {
                    filetypes = { 'js', 'html' },
                    extra_filetypes = { 'apex', 'vue' },
                    extra_args = {
                        '--plugin=prettier-plugin-apex',
                        '--write',
                        '--single-attribute-per-line=""true"',
                    },
                },
                null_ls.builtins.diagnostics.pmd.with {
                    filetypes = { 'apex' },
                    command = { 'pmd' },
                    args = {
                        'check',
                        '--format',
                        'json',
                        '--dir',
                        '$ROOT',
                        '--rulesets',
                        'apex_ruleset.xml',
                        '--no-cache',
                        '--no-progress',
                    },
                },
                -- Lua
                null_ls.builtins.formatting.stylua,
                -- Common
                null_ls.builtins.formatting.markdownlint,
                null_ls.builtins.diagnostics.typos,
                null_ls.builtins.completion.spell,
            },
        }
    end,
}
