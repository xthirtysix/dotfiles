return {
	-- biome-проект = biome.json(c) или @biomejs/biome в package.json (см. core/root.lua)
	root_dir = function(bufnr, on_dir)
		local root = require("core.root").biome(bufnr)
		if root then
			on_dir(root)
		end
	end,
}
