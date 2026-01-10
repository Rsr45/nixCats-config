require('lze').load {
    {
        "conform.nvim",
        for_cat = 'format',
        -- cmd = { "" },
        -- event = "",
        -- ft = "",
        keys = {
            { "<leader>cf", desc = "Format" },
            { "<leader>lf", desc = "LSP: Format" },
        },
        -- colorscheme = "",
        after = function(plugin)
            local conform = require("conform")

            conform.setup({
                formatters_by_ft = {
                    -- NOTE: download some formatters in lspsAndRuntimeDeps
                    -- and configure them here
                    lua = { "stylua" },
                    go = { "gofmt", "golint" },
                    templ = { "templ" },
                    nix = { "nixfmt", "alejandra" },
                    -- Conform will run multiple formatters sequentially
                    python = { "ruff", "isort", "black" },
                    -- Use a sub-list to run only the first available formatter
                    javascript = { { "prettierd", "prettier" } },
                },
            })

            vim.keymap.set({ "n", "v" }, "<leader>cf", function()
                conform.format({
                    lsp_fallback = true,
                    async = false,
                    timeout_ms = 1000,
                })
            end, { desc = "Format" })
            vim.keymap.set({ "n", "v" }, "<leader>lf", function()
                conform.format({
                    lsp_fallback = true,
                    async = false,
                    timeout_ms = 1000,
                })
            end, { desc = "LSP: Format" })
        end,
    },
}
