return {
    'echasnovski/mini.files',
    keys = {
        {
            '<leader>e',
            function()
                local MiniFiles = require 'mini.files'
                local _ = MiniFiles.close() or MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
                vim.schedule(function()
                    MiniFiles.reveal_cwd()
                end)
            end,
            noremap = true,
            desc = 'Explorer',
        },
    },
    version = false,
    config = function()
        require('mini.files').setup()
    end,
}
