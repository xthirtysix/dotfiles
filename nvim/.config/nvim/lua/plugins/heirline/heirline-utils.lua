local Color = require 'nightfox.lib.color'
local utils = require 'heirline.utils'

-- --------------------------------------------------
-- Colors
-- --------------------------------------------------
local base = Color.from_hex '#303030'

local function fade(color, amount)
    amount = amount or 0.01
    return base:blend(Color.from_hex(color), amount):to_css()
end

local colors = {
    -- bg/fg
    bright_bg = utils.get_highlight('Folded').bg,
    bright_fg = utils.get_highlight('Folded').fg,
    -- colors
    red = utils.get_highlight('DiagnosticError').fg,
    dark_red = utils.get_highlight('DiffDelete').bg,
    green = utils.get_highlight('String').fg,
    blue = utils.get_highlight('Function').fg,
    gray = utils.get_highlight('NonText').fg,
    orange = utils.get_highlight('Constant').fg,
    purple = utils.get_highlight('Statement').fg,
    cyan = utils.get_highlight('Special').fg,
    -- diagnostics
    diag_warn = utils.get_highlight('DiagnosticWarn').fg or 'yellow',
    diag_error = utils.get_highlight('DiagnosticError').fg or 'red',
    diag_hint = utils.get_highlight('DiagnosticHint').fg or 'cyan',
    diag_info = utils.get_highlight('DiagnosticInfo').fg or 'green',
    -- git
    git_del = utils.get_highlight('diffDeleted').fg or 'red',
    git_add = utils.get_highlight('diffAdded').fg or 'green',
    git_change = utils.get_highlight('diffChanged').fg or 'yellow',
}

local mode_colors = {
    n = colors.blue,
    i = colors.green,
    v = colors.purple,
    V = colors.purple,
    ['\22'] = colors.purple,
    c = colors.orange,
    s = colors.cyan,
    S = colors.cyan,
    ['\19'] = colors.cyan,
    R = colors.orange,
    r = colors.orange,
    ['!'] = colors.red,
    t = colors.cyan,
}

-- --------------------------------------------------
-- Init functions
-- --------------------------------------------------
local function initMode(self)
    self.mode = vim.fn.mode(1)
end

local function initHasGit(self)
    local path = vim.loop.cwd() .. '/.git'
    self.has_git = vim.loop.fs_stat(path)
end

local function initColors(self)
    self.color_dark = fade(mode_colors[vim.fn.mode(1):sub(1, 1)])
    self.color_bright = mode_colors[vim.fn.mode(1):sub(1, 1)]
end

return {
    colors = colors,
    mode_colors = mode_colors,
    fade = fade,
    initMode = initMode,
    initHasGit = initHasGit,
    initColors = initColors,
}

