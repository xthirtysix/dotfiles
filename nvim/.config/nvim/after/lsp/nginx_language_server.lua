return {
	filetypes = { "nginx" },

	root_dir = function(bufnr, on_dir)
		local root = vim.fs.root(bufnr, { "nginx.conf", ".git" })
		on_dir(root or vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr)))
	end,
}
