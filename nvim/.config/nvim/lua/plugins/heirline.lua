return {
    'rebelot/heirline.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
        'EdenEast/nightfox.nvim',
        -- 'abeldekat/harpoonline',
    },
    event = 'VeryLazy',
    opts = {},
    enabled = true,
    config = function(_, opts)
        local heirline = require 'heirline'

        -- Import utilities
        local heirline_utils = require 'plugins.heirline.heirline-utils'

        -- Import components
        local ViMode = require 'plugins.heirline.components.vi-mode'
        local FileName = require 'plugins.heirline.components.file-name'
        local Git = require 'plugins.heirline.components.git'
        local GitDiff = require 'plugins.heirline.components.git-diff'
        local Diagnostics = require 'plugins.heirline.components.diagnostics'
        local LSPActive = require 'plugins.heirline.components.lsp-active'
        local LinterActive = require 'plugins.heirline.components.linter-active'
        local Ruler = require 'plugins.heirline.components.ruler'
        local Common = require 'plugins.heirline.components.common'

        heirline.setup(opts)

        -- --------------------------------------------------
        -- Plugin init
        -- --------------------------------------------------
        require('heirline').setup {
            statusline = {
                init = function(self)
                    heirline_utils.initMode(self)
                    heirline_utils.initColors(self)
                    heirline_utils.initHasGit(self)
                end,
                hl = { bg = '#25273a' },
                Common.Space,
                ViMode,
                FileName,
                Git,
                GitDiff,
                Common.Space,
                Diagnostics,
                Common.Align,
                Common.Align,
                Common.Align,
                Common.Align,
                Common.Space,
                LSPActive,
                LinterActive,
                Ruler,
                Common.Space,
            },
            opts = {
                colors = heirline_utils.colors,
            },
        }
    end,
}

