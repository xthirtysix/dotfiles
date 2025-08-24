return {
    'echasnovski/mini.pick',
    config = function()
        local pick = require('mini.pick')
        pick.setup {
            mappings = {
                choose       = '<C-l>',
                move_down    = '<C-j>',
                move_up      = '<C-k>',
                move_start   = '<C-h>',
                scroll_left  = '<C-p>',
                scroll_right = '<C-b>',
            }
        }
    end
}
