return {
    'folke/snacks.nvim',
    opts = {
        dashboard = {
            sections = {
                {
                    header = [[
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣠⣤⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⣾⣿⣿⠟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⣿⣿⣿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠻⣿⣶⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣾⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⢿⣿⣿⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⢠⣿⣷⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣷⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⣿⣿⣿⣿⣿⣿⣧⠀⠀⠀⠀⢠⣿⣿⣿⣿⣄⢀⣀⣀⣀⣀⣀⣀⣀⣀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⣿⣿⣿⣿⣿⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣦⣀⣠⠴⠚⢛⣛⣭⣥⣽⣶⣶⣶⣶⣶⣶⣶⣶⣴⣮⣭⣛⣒⡢⢤⣄⣀⡀⠀⠀⣠⣿⣿⣿⣿⣿⣿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⣿⣿⣿⣿⡿⠟⣃⣀⣴⢶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡭⢟⣵⣿⣿⣿⣿⣿⣿⠇⣀⣀⡀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⣿⡿⠛⣹⣶⠿⣿⣿⣷⡿⠿⢿⣿⠿⠛⠛⠛⠛⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⣻⣴⣿⣿⣿⣿⣿⣿⣿⡟⢸⣿⡿⠃⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⢲⣶⣶⣶⣶⡾⣉⣤⣾⣿⣿⣿⠿⣿⣿⣋⣙⣿⡇⢀⠀⠰⣿⡷⠀⢹⣿⠛⠛⣿⣿⣿⣿⣿⣿⣿⣿⠀⢿⣿⣿⣿⣿⣿⣿⣿⣿⠁⠟⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠹⣿⠟⣋⣵⣿⢏⣾⣿⣿⢻⣥⣶⣿⣿⣿⣿⣷⣌⣻⠷⠖⢀⣠⣿⡛⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣤⣙⠿⠿⣿⣿⠿⠿⣛⣤⣅⣤⣠⣤⣤⣤⣶⣶⡄⠀⠀
⠀⠀⠀⠀⠀⠀⢠⡾⣒⣿⡟⣡⣦⣿⣿⣿⡇⣩⣛⠿⠿⠿⠿⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⡛⢛⣛⣛⠿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣶⣾⣿⡿⣫⣵⣿⣿⣿⣿⣿⣿⠟⠋⠀⠀⠀
⠀⠀⠀⠀⠀⠀⣾⢡⣿⠿⠙⣽⡶⠿⣿⣿⣧⣛⣵⡄⢀⡀⠀⠀⠀⠈⠙⠻⠿⡿⠿⠿⠿⠟⢊⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⣙⠻⠿⠿⢿⡿⠟⠁⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⣼⠃⣿⣿⡷⢿⠟⣩⣾⣿⣿⣿⣿⣿⡇⠀⣟⡷⠀⠀⠀⠀⠀⠀⢺⡿⠃⠀⣰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠛⣧⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⣿⢠⣿⣿⡶⣿⣟⣿⣿⣿⣿⣿⣿⣿⠇⠀⢁⣤⣶⠞⣡⣴⣶⣶⣶⠚⣡⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⣿⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠘⡷⢸⣿⣿⣵⡿⢿⣩⣷⣿⣿⣿⣿⠟⢀⣴⣿⣿⣷⣿⣿⣿⠟⢋⣤⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠃⣿⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⣷⠸⣿⣯⣠⡿⠦⠿⣿⣿⣿⣿⣿⢀⣾⣿⡿⢻⣿⠻⣫⣤⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⢡⡟⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⢻⡄⢿⣿⣗⢳⡶⢷⣿⣿⣿⣿⣿⣿⣶⣶⣶⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠇⢸⠇⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠘⣇⡘⣿⣿⣞⣿⣶⢟⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⣰⡟⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⣽⣷⡌⢿⣿⣿⣻⡿⢛⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡏⣴⠟⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠰⠿⠿⠿⠿⣆⠹⣿⣿⣷⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⣡⡶⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢶⣉⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⢋⣩⣍⣉⠛⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢿⣡⣴⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠱⢦⡍⠛⠻⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣯⣄⢻⣿⣿⣿⡇⣿⣿⣿⣿⣿⣿⣿⣟⣏⣴⠿⠻⢿⣿⣿⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠛⠶⣬⣙⡙⠿⠿⢿⣿⣿⣿⣿⣿⣿⣿⣷⣝⢿⣿⡇⡿⢿⠟⣻⡿⠷⠚⠉⠁⠀⠀⠀⠀⠉⠛⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠛⠒⠲⣷⣭⣭⣭⣭⣭⣭⣭⡴⢍⢠⠛⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
                    ]],
                },
                {
                    pane = 2,
                    icon = ' ',
                    title = 'Recent Files',
                    section = 'recent_files',
                    indent = 4,
                    padding = 4,
                },
                { pane = 2, icon = ' ', title = 'Projects', section = 'projects', indent = 4, padding = 4 },
                {
                    pane = 2,
                    icon = ' ',
                    title = 'Git Status',
                    section = 'terminal',
                    -- enabled = function()
                    --     return Snacks.git.get_root() ~= nil
                    -- end,
                    cmd = 'git status --short --branch --renames',
                    height = 5,
                    padding = 1,
                    ttl = 5 * 60,
                    indent = 4,
                },
                { section = 'startup' },
            },
        },
    },
}
