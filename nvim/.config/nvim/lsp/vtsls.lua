local result = vim.system({ 'pnpm', 'root', '-g' }):wait()

if result.code ~= 0 then
    error('Failed to get pnpm global root')
end

local global_root = vim.trim(result.stdout)

local vue_plugin = {
    name = '@vue/typescript-plugin',
    location = global_root .. '/@vue/language-server',
    languages = { 'vue' },
    configNamespace = 'typescript',
}

return {
    settings = {
        vtsls = {
            tsserver = {
                globalPlugins = {
                    vue_plugin,
                },
                settings = {
                    javascript = {
                        inlayHints = {
                            includeInlayEnumMemberValueHints = true,
                            includeInlayFunctionLikeReturnTypeHints = true,
                            includeInlayFunctionParameterTypeHints = true,
                            includeInlayParameterNameHints = 'all',
                            includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                            includeInlayPropertyDeclarationTypeHints = true,
                            includeInlayVariableTypeHints = false,
                        },
                    },
                    typescript = {
                        inlayHints = {
                            includeInlayEnumMemberValueHints = true,
                            includeInlayFunctionLikeReturnTypeHints = true,
                            includeInlayFunctionParameterTypeHints = true,
                            includeInlayParameterNameHints = 'all',
                            includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                            includeInlayPropertyDeclarationTypeHints = true,
                            includeInlayVariableTypeHints = false,
                        },
                    },
                },
            },
        },
    },
    filetypes = { 'typescript', 'javascript', 'vue' },
    root_markers = { 'app.config.ts', 'package.json', '.git' },
}
