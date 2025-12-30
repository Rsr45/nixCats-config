return {
    {
        "snacks.nvim",
        for_cat = "general.always",
        -- lazy = false,
        event = "VimEnter",
        keys = {
            { "<leader>ot",       mode = { "n" }, function() Snacks.terminal.toggle() end,                                     desc = "Toggle Terminal", },
            { "<leader>U",        mode = { "n" }, function() Snacks.picker.undo() end,                                         desc = "Undo", },
            { "<leader>,",        mode = { "n" }, function() Snacks.picker.buffers() end,                                      desc = "Buffers", },
            { "<leader>.",        mode = { "n" }, function() Snacks.explorer.open({ cwd = vim.fn.expand('%:p:h') }) end,       desc = "Explorer", },
            { "<leader>/",        mode = { "n" }, function() Snacks.picker.grep() end,                                         desc = "Grep", },
            { "<leader>:",        mode = { "n" }, function() Snacks.picker.command_history() end,                              desc = "Command History" },
            { "<leader><leader>", mode = { "n" }, function() Snacks.picker.files() end,                                        desc = "Files", },
            -- File + find
            { "<leader>ff",       mode = { "n" }, function() Snacks.picker.files() end,                                        desc = "Files", },
            { "<leader>fF",       mode = { "n" }, function() Snacks.picker.files({ cwd = vim.fn.expand('%:p:h') }) end,        desc = "Files cwd", },
            { "<leader>fr",       mode = { "n" }, function() Snacks.picker.recent() end,                                       desc = "Recent", },
            { "<leader>fG",       mode = { "n" }, function() Snacks.picker.grep_word() end,                                    desc = "Grep Word" },
            { "<leader>fd",       mode = { "n" }, function() Snacks.picker.diagnostics() end,                                  desc = "Diagnostics" },
            { "<leader>fD",       mode = { "n" }, function() Snacks.picker.diagnostics_buffers() end,                          desc = "Diagnostics Buffers" },
            { "<leader>fe",       mode = { "n" }, function() Snacks.explorer() end,                                            desc = "Explorer" },
            -- Buffer
            { "<leader>bb",       mode = { "n" }, function() Snacks.picker.buffers() end,                                      desc = "Buffers", },
            -- Search
            { "<leader>sp",       mode = { "n" }, function() Snacks.picker.grep() end,                                         desc = "Grep", },
            { "<leader>sb",       mode = { "n" }, function() Snacks.picker.lines({ layout = { preset = 'vertico' } }) end,     desc = "Lines" },
            { "<leader>sB",       mode = { "n" }, function() Snacks.picker.grep_buffers() end,                                 desc = "Grep Buffers", },
            { "<leader>sd",       mode = { "n" }, function() Snacks.picker.grep_buffers({ cwd = vim.fn.expand('%:p:h') }) end, desc = "Grep Buffers cwd", },
            { "<leader>sn",       mode = { "n" }, function() Snacks.picker.notifications() end,                                desc = "Notifications", },
            -- Project
            { "<leader>pp",       mode = { "n" }, function() Snacks.picker.projects() end,                                     desc = "Projects", },
            -- LSP
            { "<leader>ls",       mode = { "n" }, function() Snacks.picker.lsp_symbols() end,                                  desc = "Document Symbols" },
            { "<leader>ld",       mode = { "n" }, function() Snacks.picker.lsp_symbols() end,                                  desc = "[D]ocument [S]ymbols" },
            { "<leader>lS",       mode = { "n" }, function() Snacks.picker.lsp_workspace_symbols() end,                        desc = "Workspace Symbols" },
            { "<leader>lw",       mode = { "n" }, function() Snacks.picker.lsp_workspace_symbols() end,                        desc = "[W]orkspace [S]ymbols" },
            { "<leader>gr",       mode = { "n" }, function() Snacks.picker.lsp_references() end,                               desc = "[G]oto [R]eferences" },
            { "<leader>gI",       mode = { "n" }, function() Snacks.picker.lsp_implementations() end,                          desc = "[G]oto [I]mplementation" },
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
                indent = {
                    priority = 1,
                    animate = {
                        enabled = false,
                    },
                    char = "╎",
                    scope = {
                        -- char = "┆",
                        char = "╎",
                        underline = false,
                    },
                },
                image = {
                    doc = {
                        inline = false,
                        max_width = 45,
                        max_height = 20,
                    },
                },
                dashboard = {
                    enabled = true,
                    width = 5,
                    preset = {
                        header = [[

   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆
    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦
          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄
           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄
          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀
   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄
  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄
 ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄
 ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄
   ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆
    ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃]],
                    },
                    sections = {
                        -- header
                        { section = "header" },
                        {
                            padding = 1,
                            text = {
                                { "Neovim :: λ Mesa", hl = "function" },
                            },
                            align = "center",
                        },
                        -- keys
                        {
                            text = {
                                { "   ", hl = "WarningMsg" },
                                { "Find file", hl = "function", width = 40 },
                                { "[f]", hl = "QuickFixLine" },

                            },
                            action = ":lua Snacks.dashboard.pick('files')",
                            key = "f",
                            align = "center",
                        },
                        {
                            text = {
                                { "   ", hl = "WarningMsg" },
                                { "New file", hl = "function", width = 40 },
                                { "[n]", hl = "QuickFixLine" },
                            },
                            action = ":ene | startinsert",
                            key = "n",
                            align = "center",
                        },
                        {
                            -- padding = 0.7,
                            text = {
                                { "󰐮   ", hl = "WarningMsg" },
                                { "Open project", hl = "function", width = 40 },
                                { "[p]", hl = "QuickFixLine" },
                            },
                            action = function() Snacks.picker.projects() end,
                            key = "p",
                            align = "center",
                        },
                        {
                            text = {
                                { "   ", hl = "WarningMsg" },
                                { "Quit", hl = "function", width = 40 },
                                { "[q]", hl = "QuickFixLine" },
                            },

                            action = ":quitall",
                            key = "q",
                            align = "center",
                        },
                    },
                    formats = {
                        key = function(item)
                            return { { "[", hl = "Keyword" }, { item.key, hl = "Function" }, { "]", hl = "Keyword" } }
                        end,
                    },
                },
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
                    prompt = " [] :",
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
                                backdrop = false,
                                row = -1,
                                width = 0,
                                height = 0.3,
                                position = "bottom",
                                { win = "input", height = 1, },
                                {
                                    box = "horizontal",
                                    { win = "list",    border = "none" },
                                    { win = "preview", title = "{preview}", width = 0.6, border = "left" },
                                },
                            },
                        },
                    },
                    layout = "vertico",

                    sources = {
                        explorer = {
                            tree = false,
                            layout = { preset = "vertico" },
                            auto_close = true,
                        },
                        buffers = {
                            current = false,
                        },
                    },

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
                    snacks_image = {
                        relative = "editor",
                        col = -1,
                    },
                },
            })
        end,
    },
}
