return {
	settings = {
		-- форматирование eslint = применение всех автофиксов (см. core/eslint_fix.lua)
		format = true,

		codeActionOnSave = {
			enable = false,
		},

		workingDirectory = { mode = "auto" },

		run = "onType",
	},

	filetypes = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"vue",
	},
}
