local root = require("core.root")

-- `pnpm root -g` занимает ~250 мс, поэтому путь кэшируется в файл
local cache_file = vim.fn.stdpath("cache") .. "/vue_language_server_path"

local function vue_language_server_path()
	local f = io.open(cache_file)
	if f then
		local cached = f:read("*l")
		f:close()
		if cached and vim.uv.fs_stat(cached) then
			return cached
		end
	end

	if vim.fn.executable("pnpm") == 0 then
		vim.notify("vtsls: pnpm not found, Vue support disabled", vim.log.levels.WARN)
		return nil
	end

	local ok, res = pcall(function()
		return vim.system({ "pnpm", "root", "-g" }, { text = true }):wait()
	end)
	if not ok or res.code ~= 0 then
		return nil
	end

	local path = vim.trim(res.stdout or "") .. "/@vue/language-server"
	if not vim.uv.fs_stat(path) then
		vim.notify("vtsls: @vue/language-server not installed globally (pnpm add -g @vue/language-server)", vim.log.levels.WARN)
		return nil
	end

	f = io.open(cache_file, "w")
	if f then
		f:write(path)
		f:close()
	end
	return path
end

local vue_path = vue_language_server_path()
local global_plugins = vue_path
		and {
			{
				name = "@vue/typescript-plugin",
				location = vue_path,
				languages = { "vue" },
				configNamespace = "typescript",
			},
		}
	or {}

return {
	filetypes = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"vue",
	},

	root_dir = function(bufnr, on_dir)
		local dir = root.ts(bufnr)
		if dir then
			on_dir(dir)
		end
	end,

	settings = {
		typescript = {
			preferences = {
				importModuleSpecifier = "relative",
			},
		},

		vtsls = {
			tsserver = {
				globalPlugins = global_plugins,
			},
		},
	},
}
