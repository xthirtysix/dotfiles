-- "bookmarks" buffers
return {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim', 'letieu/harpoon-lualine', 'rcarriga/nvim-notify' },
    keys = {
        {
            '<leader>hl',
            function()
                local Snacks = require 'snacks'
                local harpoon = require 'harpoon'
                harpoon:setup {}

                local file_paths = {}
                for _, item in ipairs(harpoon:list().items) do
                    table.insert(file_paths, item.value)
                end

                if #file_paths <= 0 then
                    return require 'notify'(" Nothing's harpooned", 'warn', { title = 'Harpoon ⇁ ' })
                end

                return Snacks.picker.pick('files', {
                    dirs = file_paths,
                    layout = {
                        layout = {
                            backdrop = false,
                            width = 0.5,
                            min_width = 80,
                            height = 0.8,
                            min_height = 30,
                            box = 'vertical',
                            border = 'rounded',
                            title = 'Harpoon ⇁',
                            title_pos = 'center',
                            { win = 'input', height = 1, border = 'bottom' },
                            { win = 'list', height = 0.15, border = 'none' },
                            { win = 'preview', title = '{preview}', border = 'top' },
                        },
                    },
                })
            end,
            desc = 'List items',
        },
        {
            '<leader>hq',
            function()
                local harpoon = require 'harpoon'
                harpoon:setup {}
                harpoon:list():select(1)
            end,
            desc = 'Select 1',
        },
        {
            '<leader>hw',
            function()
                local harpoon = require 'harpoon'
                harpoon:setup {}
                harpoon:list():select(2)
            end,
            desc = 'Select 2',
        },
        {
            '<leader>he',
            function()
                local harpoon = require 'harpoon'
                harpoon:setup {}
                harpoon:list():select(3)
            end,
            desc = 'Select 3',
        },
        {
            '<leader>hr',
            function()
                local harpoon = require 'harpoon'
                harpoon:setup {}
                harpoon:list():select(4)
            end,
            desc = 'Select 4',
        },
        {
            '<leader>ha',
            function()
                local harpoon = require 'harpoon'
                harpoon:setup {}
                harpoon:list():add()
            end,
            desc = 'Append to list',
        },
        {
            '<leader>hd',
            function()
                local harpoon = require 'harpoon'
                harpoon:setup {}
                harpoon:list():remove()
            end,
            desc = 'Delete from list',
        },
        {
            '<leader>hn',
            function()
                local harpoon = require 'harpoon'
                harpoon:setup {}
                harpoon:list():next()
            end,
            desc = 'Next file',
        },
        {
            '<leader>hp',
            function()
                local harpoon = require 'harpoon'
                harpoon:setup {}
                harpoon:list():prev()
            end,
            desc = 'Prev file',
        },
    },
}
