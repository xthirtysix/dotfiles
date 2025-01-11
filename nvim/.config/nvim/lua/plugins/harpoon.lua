return {
    'ThePrimeagen/harpoon',
    keys = {
        {
            '<leader>hl',
            function()
                local harpoon = require 'harpoon'
                harpoon:setup {}

                local conf = require('telescope.config').values
                local function toggle_telescope(harpoon_files)
                    local file_paths = {}
                    for _, item in ipairs(harpoon_files.items) do
                        table.insert(file_paths, item.value)
                    end

                    require('telescope.pickers')
                        .new({}, {
                            prompt_title = 'Harpoon',
                            finder = require('telescope.finders').new_table {
                                results = file_paths,
                            },
                            previewer = conf.file_previewer {},
                            sorter = conf.generic_sorter {},
                        })
                        :find()
                end
                toggle_telescope(harpoon:list())
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
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim', 'letieu/harpoon-lualine' },
    config = function() end,
}
