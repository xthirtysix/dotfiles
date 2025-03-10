return {
    'stevearc/conform.nvim',
    keys = {

        { '<leader>lf', vim.lsp.buf.format, desc = 'Format with null_ls' },
        {
            '<leader>f',
            function()
                local conform = require 'conform'

                conform.format {
                    lsp_fallback = true,
                    async = false,
                    timeout_ms = 2500,
                }
            end,
            mode = { 'n', 'v' },
            desc = 'Format',
        },
    },
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
        format_on_save = {
            timeout_ms = 2500,
            lsp_fallback = true,
        },
    },
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
