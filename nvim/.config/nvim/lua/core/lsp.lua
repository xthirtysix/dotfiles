local function on_attach(_, bufnr)
	local function map(lhs, rhs, desc, opts)
		opts = vim.tbl_extend("force", { buffer = bufnr, silent = true, desc = desc }, opts or {})
		vim.keymap.set("n", lhs, rhs, opts)
	end

	map("gd", function()
		Snacks.picker.lsp_definitions()
	end, "Go to definition")
	map("gD", vim.lsp.buf.declaration, "Go to declaration")
	map("gr", function()
		Snacks.picker.lsp_references()
	end, "References", { nowait = true }) -- не ждать встроенные grn/grr/gra/...
	map("gi", function()
		Snacks.picker.lsp_implementations()
	end, "Implementation")
	map("gy", function()
		Snacks.picker.lsp_type_definitions()
	end, "Type definition")

	map("<leader>ss", function()
		Snacks.picker.lsp_symbols()
	end, "Document symbols")
	map("<leader>sS", function()
		Snacks.picker.lsp_workspace_symbols()
	end, "Workspace symbols")

	map("<leader>ci", vim.lsp.buf.incoming_calls, "Incoming calls")
	map("<leader>co", vim.lsp.buf.outgoing_calls, "Outgoing calls")

	map("K", vim.lsp.buf.hover, "Hover")
	-- встроенный code_action сам подставляет диагностики строки; в visual — для диапазона
	vim.keymap.set({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code action" })
	map("<leader>rn", vim.lsp.buf.rename, "Rename")
	map("<leader>cd", vim.diagnostic.open_float, "Line diagnostics")
end

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)

		if not client then
			return
		end

		on_attach(client, args.buf)
	end,
})

vim.lsp.enable({
	"vtsls",
	"vue_ls",
	"eslint",
	"cssls",
	"yamlls",
	"gopls",
	"nginx_language_server",
})
