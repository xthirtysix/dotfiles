local M = {}

local NUXT = { "nuxt.config.ts", "nuxt.config.js", "nuxt.config.mjs", "nuxt.config.cjs" }

local function start_dir(bufnr)
	local path = vim.api.nvim_buf_get_name(bufnr or 0)
	if path == "" then
		return vim.fn.getcwd()
	end
	return vim.fs.dirname(path)
end

local function find(bufnr, groups)
	bufnr = bufnr or 0
	if vim.api.nvim_buf_get_name(bufnr) == "" then
		return nil
	end
	for _, group in ipairs(groups) do
		local root = vim.fs.root(bufnr, group)
		if root then
			return root
		end
	end
end

function M.get(bufnr)
	return find(bufnr, {
		NUXT,
		{ "package.json", "tsconfig.json", "jsconfig.json", "go.mod" },
		{ ".git" },
	}) or start_dir(bufnr)
end

function M.ts(bufnr)
	return find(bufnr, { NUXT, { "tsconfig.json", "jsconfig.json" } })
end

function M.workspace(bufnr)
	return find(bufnr, { { "pnpm-workspace.yaml" }, { ".git" } })
end

function M.up(dir, relpath)
	while dir and dir ~= "" do
		local p = dir .. "/" .. relpath
		if vim.uv.fs_stat(p) then
			return p
		end
		local parent = vim.fs.dirname(dir)
		if parent == dir then
			return nil
		end
		dir = parent
	end
end

function M.bin(name, bufnr)
	return M.up(start_dir(bufnr), "node_modules/.bin/" .. name)
end

local BIOME_CONFIGS = { "biome.json", "biome.jsonc" }
local BIOME_PACKAGE = "@biomejs/biome"

local function package_uses_biome(path)
	local ok, lines = pcall(vim.fn.readfile, path)
	return ok and table.concat(lines, "\n"):find(BIOME_PACKAGE, 1, true) ~= nil
end

-- корень biome-проекта: biome.json(c) или @biomejs/biome в ближайшем package.json вверх по дереву
local function biome_root(bufnr)
	local config_root = find(bufnr, { BIOME_CONFIGS })
	if config_root then
		return config_root
	end
	local packages = vim.fs.find("package.json", { path = start_dir(bufnr), upward = true, limit = math.huge })
	for _, path in ipairs(packages) do
		if package_uses_biome(path) then
			return vim.fs.dirname(path)
		end
	end
end

-- корень проекта с biome, если сам бинарник доступен (иначе nil -> prettier)
function M.biome(bufnr)
	local root = biome_root(bufnr)
	if root and (M.bin("biome", bufnr) or vim.fn.executable("biome") == 1) then
		return root
	end
end

function M.tsdk(dir)
	return M.up(dir, "node_modules/typescript/lib")
end

vim.api.nvim_create_user_command("ProjectTools", function()
	vim.print({
		root = M.get(0),
		ts_root = M.ts(0),
		workspace = M.workspace(0),
		tsdk = M.tsdk(M.ts(0) or start_dir(0)),
		biome_root = M.biome(0),
		biome = M.bin("biome", 0),
		prettier = M.bin("prettier", 0),
		eslint = M.bin("eslint", 0),
	})
end, {})

return M
