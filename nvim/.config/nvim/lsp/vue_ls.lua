vim.lsp.config('vue_ls', {
    filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
    root_markers = { 'vite.config.ts', 'package.json', '.git' },
})
