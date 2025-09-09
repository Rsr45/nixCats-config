return {
    {
        "snacks.nvim",
        for_cat = "general.always",
        lazy = false,
        keys = {
            {
                "<leader>u",
                "<cmd>lua Snacks.picker.undo()<CR>",
                mode = { "n" },
                desc = "Undo"
            },
            -- {
            --     "<leader>ff",
            --     "<cmd>lua Snacks.picker.files()<CR>",
            --     mode = { "n" },
            --     desc = "Files"
            -- },
            -- {
            --     "<leader>fF",
            --     "<cmd>lua Snacks.picker.files({ cwd = vim.fn.expand('%:p:h') })<CR>",
            --     mode = { "n" },
            --     desc = "Files in cwd"
            -- },
            -- {
            --     "<leader>fb",
            --     "<cmd>lua Snacks.picker.buffers()<CR>",
            --     mode = { "n" },
            --     desc = "Buffer"
            -- },
            -- {
            --     "<leader>fg",
            --     "<cmd>lua Snacks.picker.grep()<CR>",
            --     mode = { "n" },
            --     desc = "Grep"
            -- },
            -- {
            --     "<leader>fG",
            --     "<cmd>lua Snacks.picker.grep_word()<CR>",
            --     mode = { "n" },
            --     desc = "Grep Word Under Cursor"
            -- },
            -- {
            --     "<leader>fs",
            --     "<cmd>lua Snacks.picker.lsp_symbols()<CR>",
            --     mode = { "n" },
            --     desc = "Document Symbols"
            -- },
            -- {
            --     "<leader>fws",
            --     "<cmd>lua Snacks.picker.lsp_symbols()<CR>",
            --     mode = { "n" },
            --     desc = "[D]ocument [S]ymbols"
            -- },
            -- {
            --     "<leader>fS",
            --     "<cmd>lua Snacks.picker.lsp_workspace_symbols()<CR>",
            --     mode = { "n" },
            --     desc = "Workspace Symbols"
            -- },
            -- {
            --     "<leader>fwS",
            --     "<cmd>lua Snacks.picker.lsp_workspace_symbols()<CR>",
            --     mode = { "n" },
            --     desc = "[W]orkspace [S]ymbols"
            -- },
            -- {
            --     "<leader>fd",
            --     "<cmd>lua Snacks.picker.diagnostics()<CR>",
            --     mode = { "n" },
            --     desc = "Diagnostics"
            -- },
            -- {
            --     "<leader>fD",
            --     "<cmd>lua Snacks.picker.diagnostics_buffers()<CR>",
            --     mode = { "n" },
            --     desc = "Diagnostics Buffers"
            -- },
            -- {
            --     "<leader>gr",
            --     "<cmd>lua Snacks.picker.lsp_references()<CR>",
            --     mode = { "n" },
            --     desc = "[G]oto [R]eferences"
            -- },
            -- {
            --     "<leader>gI",
            --     "<cmd>lua Snacks.picker.lsp_implementations()<CR>",
            --     mode = { "n" },
            --     desc = "[G]oto [I]mplementation"
            -- },
            -- {
            --     "<leader>ft",
            --     "<cmd>lua Snacks.explorer()<CR>",
            --     mode = { "n" },
            --     desc = "Explorer"
            -- },
        },
        after = function()
            require("snacks").setup({
                statuscolumn = {
                    -- your statuscolumn configuration comes here
                    -- or leave it empty to use the default settings
                    -- refer to the configuration section below
                    left = { "mark", "sign" }, -- priority of signs on the left (high to low)
                    right = { "fold", "git" }, -- priority of signs on the right (high to low)
                    folds = {
                        open = false,      -- show open fold icons
                        git_hl = false,    -- use Git Signs hl for fold icons
                    },
                    git = {
                        -- patterns to match Git signs
                        patterns = { "GitSign", "MiniDiffSign" },
                    },
                    refresh = 50, -- refresh at most every 50ms
                },
            })
        end,
    },
}
