vim.lsp.enable({ 'lua_ls', 'tailwindcss', 'vue_ls', 'vtsls' })

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
            vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'fuzzy', 'popup' }
            vim.lsp.completion.enable(false, client.id, ev.buf, { autotrigger = true })
            vim.keymap.set('i', '<C-k>', function()
                vim.lsp.completion.get()
            end)
        end
    end,
})

vim.diagnostic.config({
    virtual_lines = {
        current_line = true,
    },
})

vim.diagnostic.config {
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = ' ',
      [vim.diagnostic.severity.WARN]  = ' ',
      [vim.diagnostic.severity.HINT]  = ' ',
      [vim.diagnostic.severity.INFO]  = ' ',
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
      [vim.diagnostic.severity.WARN]  = 'DiagnosticSignWarn',
      [vim.diagnostic.severity.HINT]  = 'DiagnosticSignHint',
      [vim.diagnostic.severity.INFO]  = 'DiagnosticSignInfo',
    },
  },
  virtual_text = { prefix = '' },
}

