return {
	{
		"Wansmer/langmapper.nvim",
		lazy = false,
		-- грузится раньше остальных, чтобы hack_keymap успел обернуть их маппинги
		priority = 1000,

		config = function()
			local langmapper = require("langmapper")

			langmapper.setup({
				layouts = {
					ru = {
						id = "com.apple.keylayout.Russian",
					},
				},
				os = {
					Darwin = {
						-- без im-select не дергаем несуществующий бинарь
						get_current_layout_id = function()
							if vim.fn.executable("im-select") == 0 then
								return nil
							end

							local output = vim.split(vim.trim(vim.fn.system("im-select")), "\n")
							return output[#output]
						end,
					},
				},
			})

			-- keymaps.lua и встроенные маппинги заданы до hack_keymap — переводим их отдельно
			vim.api.nvim_create_autocmd("User", {
				pattern = "VeryLazy",
				once = true,
				callback = function()
					langmapper.automapping({ global = true, buffer = false })
				end,
			})
		end,
	},
}
