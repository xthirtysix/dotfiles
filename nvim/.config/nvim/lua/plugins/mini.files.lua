return {
    'echasnovski/mini.files',
    keys = {
        {
            '<leader>e',
            '<Cmd>lua MiniFiles.open()<CR>',
            noremap = true,
            desc = 'Explorer',
        },
    },
    version = false,
    config = function()
        require('mini.files').setup()
    end,
}
