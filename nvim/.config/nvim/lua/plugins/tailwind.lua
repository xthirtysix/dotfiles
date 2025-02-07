-- tailwind-tools.lua
return {
    'luckasRanarison/tailwind-tools.nvim',
    name = 'tailwind-tools',
    build = ':UpdateRemotePlugins',
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'neovim/nvim-lspconfig',
    },
    opts = {},
}
