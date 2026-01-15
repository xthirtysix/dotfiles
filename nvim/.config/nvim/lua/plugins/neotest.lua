return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "marilari88/neotest-vitest",
    },
    config = function()
        require("neotest").setup({
            adapters = {
                require("neotest-vitest"),
            },
            summary = {
                open = "botright vsplit | vertical resize 90",
            },
        })
    end,
    keys = {
        { "<leader>tt", function() require("neotest").run.run() end,                     desc = "Run nearest test" },
        { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end,   desc = "Run file" },
        { "<leader>ts", function() require("neotest").summary.toggle() end,              desc = "Toggle summary" },
        { "<leader>to", function() require("neotest").output.open({ enter = true }) end, desc = "Show output" },
    },
}
