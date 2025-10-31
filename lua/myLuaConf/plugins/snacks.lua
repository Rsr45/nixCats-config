return {
    {
        "snacks.nvim",
        for_cat = "general.always",
        lazy = false,
        keys = {
            { "<leader>ot",       mode = { "n" }, "<cmd>lua Snacks.terminal.toggle()<CR>",                                     desc = "Toggle terminal popup", },
            { "<leader>sn",       mode = { "n" }, "<cmd>lua Snacks.picker.notifications()<CR>",                                desc = "Search notifications", },
            { "<leader>u",        mode = { "n" }, "<cmd>lua Snacks.picker.undo()<CR>",                                         desc = "Undo", },
            { "<leader>,",        mode = { "n" }, "<cmd>lua Snacks.picker.buffers()<CR>",                                      desc = "Switch buffer", },
            { "<leader>.",        mode = { "n" }, "<cmd>lua Snacks.picker.files({ cwd = vim.fn.expand('%:p:h')})<CR>",         desc = "Find file", },
            { "<leader>/",        mode = { "n" }, "<cmd>lua Snacks.picker.grep()<CR>",                                         desc = "Grep", },
            { "<leader><leader>", mode = { "n" }, "<cmd>lua Snacks.picker.files()<CR>",                                        desc = "Find file in project", },
            -- File
            { "<leader>ff",       mode = { "n" }, "<cmd>lua Snacks.picker.files({ cwd = vim.fn.expand('%:p:h') })<CR>",        desc = "Files in cwd" },
            { "<leader>fF",       mode = { "n" }, "<cmd>lua Snacks.picker.files({ cwd = vim.fn.expand('%:p:h') })<CR>",        desc = "Find file from here", },
            -- Buffer
            { "<leader>bb",       mode = { "n" }, "<cmd>lua Snacks.picker.buffers()<CR>",                                      desc = "Switch buffer", },
            -- Search
            { "<leader>sp",       mode = { "n" }, "<cmd>lua Snacks.picker.grep()<CR>",                                         desc = "Search on everything", },
            { "<leader>sb",       mode = { "n" }, "<cmd>lua Snacks.picker.lines()<CR>",                                        desc = "Search buffer" },
            { "<leader>sB",       mode = { "n" }, "<cmd>lua Snacks.picker.grep_buffers()<CR>",                                 desc = "Search all open buffers", },
            { "<leader>sd",       mode = { "n" }, "<cmd>lua Snacks.picker.grep_buffers({ cwd = vim.fn.expand('%:p:h') })<CR>", desc = "Search current directory", },
            -- Project
            { "<leader>pp",       mode = { "n" }, "<cmd>lua Snacks.picker.projects()<CR>",                                     desc = "Switch project", },
            -- { "<leader>fG",       mode = { "n" }, "<cmd>lua Snacks.picker.grep_word()<CR>",                                    desc = "Grep Word Under Cursor" },
            -- { "<leader>fs",       mode = { "n" }, "<cmd>lua Snacks.picker.lsp_symbols()<CR>",                                  desc = "Document Symbols" },
            -- { "<leader>fws",      mode = { "n" }, "<cmd>lua Snacks.picker.lsp_symbols()<CR>",                                  desc = "[D]ocument [S]ymbols" },
            -- { "<leader>fS",       mode = { "n" }, "<cmd>lua Snacks.picker.lsp_workspace_symbols()<CR>",                        desc = "Workspace Symbols" },
            -- { "<leader>fwS",      mode = { "n" }, "<cmd>lua Snacks.picker.lsp_workspace_symbols()<CR>",                        desc = "[W]orkspace [S]ymbols" },
            -- { "<leader>fd",       mode = { "n" }, "<cmd>lua Snacks.picker.diagnostics()<CR>",                                  desc = "Diagnostics" },
            -- { "<leader>fD",       mode = { "n" }, "<cmd>lua Snacks.picker.diagnostics_buffers()<CR>",                          desc = "Diagnostics Buffers" },
            -- { "<leader>gr",       mode = { "n" }, "<cmd>lua Snacks.picker.lsp_references()<CR>",                               desc = "[G]oto [R]eferences" },
            -- { "<leader>gI",       mode = { "n" }, "<cmd>lua Snacks.picker.lsp_implementations()<CR>",                          desc = "[G]oto [I]mplementation" },
            -- { "<leader>ft",       mode = { "n" }, "<cmd>lua Snacks.explorer()<CR>",                                            desc = "Explorer" },
        },
        after = function()
            require("snacks").setup({
                statuscolumn = {
                    -- your statuscolumn configuration comes here
                    -- or leave it empty to use the default settings
                    -- refer to the configuration section below
                    right = { "mark", "sign" }, -- priority of signs on the left (high to low)
                    left = { "fold", "git" },   -- priority of signs on the right (high to low)
                    folds = {
                        open = false,           -- show open fold icons
                        git_hl = true,          -- use Git Signs hl for fold icons
                    },
                    git = {
                        -- patterns to match Git signs
                        patterns = { "GitSign", "MiniDiffSign" },
                    },
                    refresh = 50, -- refresh at most every 50ms
                },
                dashboard = {
                    preset = {
                        keys = {
                            {
                                icon = " ",
                                key = "f",
                                desc = "Find File",
                                action = ":lua Snacks.dashboard.pick('files')",
                            },
                            {
                                icon = " ",
                                key = "r",
                                desc = "Recently opened files",
                                action = ":lua Snacks.dashboard.pick('oldfiles')",
                            },
                            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
                            {
                                icon = " ",
                                key = "g",
                                desc = "Find Text",
                                action = ":lua Snacks.dashboard.pick('live_grep')",
                            },
                            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
                        },
                    },
                    sections = {
                        { section = "header" },
                        { section = "keys",  gap = 1, padding = 1 },
                    },
                },
                image = {},
                terminal = {},
                notify = {},
                notifier = {},
                -- words = {},
                input = {
                    win = { border = "single" },
                },
                bigfile = {},
                quickfile = {},
                explorer = {},
                picker = {
                    prompt = "[] :";
                    layouts = {
                        telescope = {
                            reverse = true,
                            layout = {
                                box = "horizontal",
                                backdrop = false,
                                width = 0.8,
                                height = 0.9,
                                border = "none",
                                {
                                    box = "vertical",
                                    { win = "list", title = " Results ", title_pos = "center", border = "single" },
                                    {
                                        win = "input",
                                        height = 1,
                                        border = "single",
                                        title = "{title} {live} {flags}",
                                        title_pos = "center",
                                    },
                                },
                                {
                                    win = "preview",
                                    title = "{preview:Preview}",
                                    width = 0.45,
                                    border = "single",
                                    title_pos = "center",
                                },
                            },
                        },
                        vertical = {
                            layout = {
                                backdrop = false,
                                width = 0.5,
                                min_width = 80,
                                height = 0.8,
                                min_height = 30,
                                box = "vertical",
                                border = "single",
                                title = "{title} {live} {flags}",
                                title_pos = "center",
                                { win = "input",   height = 1,          border = "bottom" },
                                { win = "list",    border = "none" },
                                { win = "preview", title = "{preview}", height = 0.4,     border = "top" },
                            },
                        },
                        vertico = {
                            layout = {
                                box = "vertical",
                                -- backdrop = false,
                                row = -1,
                                width = 0,
                                height = 0.4,
                                position = "bottom",
                                { win = "input", height = 1,},
                                {
                                    box = "horizontal",
                                    { win = "list", border = "none" },
                                },
                            },
                        },
                    },
                    layout = "vertico",

                    win = {
                        input = {
                            keys = {
                                ["<a-s>"] = { "flash", mode = { "n", "i" } },
                                ["s"] = { "flash" },
                            },
                        },
                    },
                    actions = {
                        flash = function(picker)
                            require("flash").jump({
                                pattern = "^",
                                label = { after = { 0, 0 } },
                                search = {
                                    mode = "search",
                                    exclude = {
                                        function(win)
                                            return vim.bo[vim.api.nvim_win_get_buf(win)].filetype
                                                ~= "snacks_picker_list"
                                        end,
                                    },
                                },
                                action = function(match)
                                    local idx = picker.list:row2idx(match.pos[1])
                                    picker.list:_move(idx, true, true)
                                end,
                            })
                        end,
                    },
                },
                styles = {
                    default = {
                        border = "single",
                    },
                    input = {
                        border = "single",
                    },
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
