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
        vim.api.nvim_create_autocmd('User', {
            pattern = 'MiniFilesActionRename',
            callback = function(event)
                Snacks.rename.on_rename_file(event.data.from, event.data.to)
            end,
        })
    end,
}
