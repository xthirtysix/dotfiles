require("options")
require("keymaps")
require("autocmd")

require("core.lazy")
require("core.lsp")
require("core.eslint_fix") -- :ToggleEslintFix
require("core.root") -- :ProjectTools
require("core.diagnostics")

vim.api.nvim_create_user_command("Lsp", function()
	local clients = vim.lsp.get_clients({ bufnr = 0 })

	if #clients == 0 then
		print("No LSP clients attached")
		return
	end

	print("LSP: " .. table.concat(
		vim.tbl_map(function(client)
			return client.name
		end, clients),
		", "
	))
end, {})

vim.filetype.add({
	pattern = {
		[".*/nginx/.*%.conf"] = "nginx",
		[".*/sites%-available/.*"] = "nginx",
		[".*/sites%-enabled/.*"] = "nginx",
		[".*/conf%.d/.*%.conf"] = "nginx",
		[".*%.nginx"] = "nginx",
		[".*%.conf%.template"] = "nginx",
	},
})

vim.cmd.colorscheme("ayu-mirage")
