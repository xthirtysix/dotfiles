-------------
-- GENERAL --
-------------
lvim.log.level = "warn"
lvim.format_on_save.enabled = false

-----------
-- THEME --
-----------
lvim.colorscheme = "nord"                              -- Ayu theme
-- require('ayu').setup({ mirage = true })               -- Ayu theme variant
lvim.builtin.lualine.options.section_separators = {
  left = "",
  right = ""
}                                                     -- Separator symbols
lvim.builtin.lualine.options.theme = "nord"     -- Lualine theme
-- lvim.builtin.lualine.options.theme = "ayu_mirage"     -- Lualine theme

------------
-- LEADER --
------------
lvim.leader = "space"

--------------
-- BINDINGS --
--------------
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"                     -- Save on Ctrl + s
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"   -- Next tab on Shift + l
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"   -- Prev tab on Shift + h

--------------------------
--  WHICH KEY BINDINGS  --
-- bindings on Space +  --
--------------------------
-- Navigate projects
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["t"] = {
  name = "+Trouble",
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
}
-- Open/focus file explorer
lvim.builtin.which_key.mappings["e"] = { "<cmd>NvimTreeFocus<CR>", "Focus expolorer" }
-- Toggle file explorer
lvim.builtin.which_key.mappings["o"] = { "<cmd>NvimTreeToggle<CR>", "Toggle expolorer"}

------------------------------
-- BUILT-IN PLUGIN SETTINGS --
------------------------------
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-----------------
-- TREESITTER  --
-- code parser --
-----------------
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "javascript",
  "json",
  "lua",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
}

lvim.builtin.treesitter.highlight.enable = true
-- Enable colored parenthesis
lvim.builtin.treesitter.rainbow.enable = true
-- Configure colored parenthesis colors (max level: 7)
lvim.builtin.treesitter.rainbow.colors = {
  "#ffd173",  -- Orange
  "#95e6cb",  -- Cyan
  "#f27983",  -- Pink
  "#5ccfe6",  -- Blue
  "#d5ff89",  -- Green
  "#f28779",  -- Red
  "#d4bfff",  -- Magenta
}

-- Bind 'apexcode' filetype to .cls file
vim.filetype.add {
  extension = {
    cls = "apexcode",
  },
}
 -- Highlight Apex code with Java treesitter parser
vim.api.nvim_create_autocmd("FileType", {
  pattern = "apexcode",
  callback = function()
    require("nvim-treesitter.highlight").attach(0, "java")
  end,
})

-------------------
-- EXTRA PLUGINS --
-------------------
lvim.plugins = {
  { "Shatur/neovim-ayu" },        -- Color theme
  { "arcticicestudio/nord-vim" }, -- Also color theme )
  { "alvan/vim-closetag" },       -- Autoclose (X)HTML-tag
  { "p00f/nvim-ts-rainbow" },     -- Colored parenthesis
}

