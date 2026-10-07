local languages = {
	"bash",
	"css",
	"go",
	"html",
	"javascript",
	"json",
	"lua",
	"nginx",
	"scss",
	"tsx",
	"typescript",
	"vue",
	"yaml",
}

return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",

		config = function()
			local treesitter = require("nvim-treesitter")

			treesitter.install(languages)

			-- FileType ждёт имена filetype, а не парсеров (tsx -> typescriptreact и т.п.)
			local filetypes = vim.iter(languages):map(vim.treesitter.language.get_filetypes):flatten():totable()

			vim.api.nvim_create_autocmd("FileType", {
				pattern = filetypes,
				callback = function(args)
					local ok, err = pcall(vim.treesitter.start, args.buf)

					if not ok then
						vim.notify(
							"Tree-sitter failed for " .. vim.bo[args.buf].filetype .. ": " .. err,
							vim.log.levels.WARN
						)
						return
					end

					vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

					local win = vim.fn.bufwinid(args.buf)
					if win ~= -1 then
						vim.wo[win][0].foldmethod = "expr"
						vim.wo[win][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
					end
				end,
			})
		end,
	},
}
