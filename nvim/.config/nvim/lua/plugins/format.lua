return {
    'stevearc/conform.nvim',
    keys = {

        { '<leader>lf', vim.lsp.buf.format, desc = 'Format file with none-ls' },
        {
            '<leader>f',
            function()
                local conform = require 'conform'

                conform.format {
                    lsp_fallback = true,
                    async = false,
                    timeout_ms = 500,
                }
            end,
            mode = { 'n', 'v' },
            desc = 'Format file or range (in visual mode)',
        },
    },
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
        local conform = require 'conform'
        conform.setup {
            formatters_by_ft = {
                javascript = { 'prettier' },
                typescript = { 'prettier' },
                css = { 'prettier' },
                html = { 'prettier' },
                json = { 'prettier' },
                yaml = { 'prettier' },
                markdown = { 'prettier' },
                graphql = { 'prettier' },
                lua = { 'stylua' },
                vue = { 'volar', 'prettier' },
                apex = { 'prettier' },
            },
        }
    end,
}
