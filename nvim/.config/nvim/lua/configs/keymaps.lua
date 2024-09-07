-- LSP
vim.keymap.set('n', '<leader>lh', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>ld', vim.lsp.buf.definition, { desc = 'Go to definition' })
vim.keymap.set('n', '<leader>lD', vim.lsp.buf.declaration, { desc = 'Go to declaration' })
vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, { desc = 'Code actions' })
vim.keymap.set('n', '<leader>li', vim.lsp.buf.hover, { desc = 'Info under cursor' })

-- format
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format, { desc = 'Format file with none-ls' })
vim.keymap.set({ 'n', 'v' }, '<leader>f', function()
    local conform = require 'conform'

    conform.format {
        lsp_fallback = true,
        async = false,
        timeout_ms = 500,
    }
end, { desc = 'Format file or range (in visual mode)' })

-- lint
vim.keymap.set('n', '<leader>l', function()
    local lint = require 'lint'
    lint.try_lint()
end, { desc = 'Lint current file' })

-- Mini files
vim.keymap.set('n', 'e', '<Cmd>lua MiniFiles.open()<CR>', { noremap = true })

-- Telescope
local builtin = require 'telescope.builtin'

vim.keymap.set('n', '<leader>tf', builtin.find_files, { desc = 'Search by file name' })
vim.keymap.set('n', '<leader>tg', builtin.live_grep, { desc = 'Grep code snippet' })

-- Harpoon
local harpoon = require 'harpoon'
harpoon:setup {}

vim.keymap.set('n', '<leader>ha', function()
    harpoon:list():add()
end, { desc = 'Append item to harpoon list' })
vim.keymap.set('n', '<leader>hr', function()
    harpoon:list():remove()
end, { desc = 'Remove item from harpoon list' })
vim.keymap.set('n', '<leader>hn', function()
    harpoon:list():next()
end, { desc = 'Go to next harpooned file' })
vim.keymap.set('n', '<leader>hp', function()
    harpoon:list():prev()
end, { desc = 'Go to previous harpooned file' })

-- PX to REM
vim.api.nvim_set_keymap('n', '<leader>px', ':PxToRemLine<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>pc', ':PxToRemCursor<CR>', { noremap = true })
