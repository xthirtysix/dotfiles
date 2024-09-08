return {
    'mfussenegger/nvim-lint',
    keys = {
        {
            '<leader>l',
            function()
                local lint = require 'lint'
                lint.try_lint()
            end,
            desc = 'Lint current file',
        },
    },
    event = {
        'BufReadPre',
        'BufNewFile',
    },
    config = function()
        local lint = require 'lint'

        lint.linters_by_ft = {
            javascript = { 'eslint' },
            typescript = { 'eslint' },
            vue = { 'eslint' },
        }

        local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })

        vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
            group = lint_augroup,
            callback = function()
                lint.try_lint()
            end,
        })
    end,
}
