return {
	filetypes = { "vue" },

	root_dir = function(bufnr, on_dir)
		local dir = require("core.root").ts(bufnr)
		if dir then
			on_dir(dir)
		end
	end,
}
