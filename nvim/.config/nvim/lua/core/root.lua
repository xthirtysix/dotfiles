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

function M.tsdk(dir)
	return M.up(dir, "node_modules/typescript/lib")
end

vim.api.nvim_create_user_command("ProjectTools", function()
	vim.print({
		root = M.get(0),
		ts_root = M.ts(0),
		workspace = M.workspace(0),
		tsdk = M.tsdk(M.ts(0) or start_dir(0)),
		prettier = M.bin("prettier", 0),
		eslint = M.bin("eslint", 0),
	})
end, {})

return M
