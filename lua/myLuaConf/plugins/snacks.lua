return {
    {
        "snacks.nvim",
        for_cat = "general.always",
        lazy = false,
        keys = {
            { "<leader>ot", mode = { "n" }, "<cmd>lua Snacks.terminal.toggle()<CR>" },
            {
                "<leader>u",
                "<cmd>lua Snacks.picker.undo()<CR>",
                mode = { "n" },
                desc = "Undo"
            },
            {
                "<leader>,",
                "<cmd>lua Snacks.picker.buffers()<CR>",
                mode = { "n" },
                desc = "Buffer"
            },
            {
                "<leader>.",
                "<cmd>lua Snacks.picker.files({ cwd = vim.fn.expand('%:p:h')})<CR>",
                mode = { "n" },
                desc = "Find file"
            },
            {
                "<leader>/",
                "<cmd>lua Snacks.picker.grep()<CR>",
                mode = { "n" },
                desc = "Grep"
            },
            {
                "<leader>ff",
                "<cmd>lua Snacks.picker.files({ cwd = vim.fn.expand('%:p:h') })<CR>",
                mode = { "n" },
                desc = "Files in cwd"
            },
            {
                "<leader><leader>",
                "<cmd>lua Snacks.picker.files()<CR>",
                mode = { "n" },
                desc = "Find file",
            },
            {
                "<leader>bb",
                "<cmd>lua Snacks.picker.buffers()<CR>",
                mode = { "n" },
                desc = "Buffer"
            },
            {
                "<leader>sp",
                "<cmd>lua Snacks.picker.grep()<CR>",
                mode = { "n" },
                desc = "Grep"
            },
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
                -- statuscolumn = {
                --     -- your statuscolumn configuration comes here
                --     -- or leave it empty to use the default settings
                --     -- refer to the configuration section below
                --     left = { "mark", "sign" }, -- priority of signs on the left (high to low)
                --     right = { "fold", "git" }, -- priority of signs on the right (high to low)
                --     folds = {
                --         open = false,          -- show open fold icons
                --         git_hl = false,        -- use Git Signs hl for fold icons
                --     },
                --     git = {
                --         -- patterns to match Git signs
                --         patterns = { "GitSign", "MiniDiffSign" },
                --     },
                --     refresh = 50, -- refresh at most every 50ms
                -- },
                -- dashboard = {
                --     preset = {
                --         -- Used by the `keys` section to show keymaps.
                --         -- Set your custom keymaps here.
                --         -- When using a function, the `items` argument are the default keymaps.
                --         ---@type snacks.dashboard.Item[]
                --         keys = {
                --             { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
                --             { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
                --             { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
                --             { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
                --             { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
                --             { icon = " ", key = "q", desc = "Quit", action = ":qa" },
                --         },
                --     },
                --     sections = {
                --         { section = "header" },
                --         { section = "keys",   gap = 1, padding = 1 },
                --         { section = "startup" },
                --     },
                -- },
                image = {},
                terminal = {},
                notify = {},
                notifier = {},
                -- words = {},
                -- input = {
                --     win = { border = "single", },
                -- },
                bigfile = {},
                quickfile = {},
                explorer = {},
                picker = {
                    layout = { preset = "ivy", },
                },
                styles = {
                    default = {
                        border = "single",
                    },
                    -- input = {
                    --     borde = "single",
                    -- },
                    notification = {
                        border = "single",
                        zindex = 100,
                        ft = "markdown",
                        wo = {
                            winblend = 5,
                            wrap = false,
                            conceallevel = 2,
                            colorcolumn = "",
                        },
                        bo = { filetype = "snacks_notif" },
                    },
                    notification_history = {
                        border = "single",
                        zindex = 100,
                        width = 0.6,
                        height = 0.6,
                        minimal = false,
                        title = " Notification History ",
                        title_pos = "center",
                        ft = "markdown",
                        bo = { filetype = "snacks_notif_history", modifiable = false },
                        wo = { winhighlight = "Normal:SnacksNotifierHistory" },
                        keys = { q = "close" },
                    },
                },
            })
        end,
    },
}
