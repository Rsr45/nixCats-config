return {
    {
        "obsidian.nvim",
        -- ft = "markdown",
        for_cat = "notes",
        cmd = { "ObsidianOpen", "ObsidianNew", "ObsidianSearch", "Obsidian" },
        keys = {
            {
                "<leader>off",
                "<cmd>Obsidian search<CR>",
                mode = { "n" },
                desc = "Search Notes"
            },
            {
                "<leaderoft>",
                "<cmd>Obsidian tags",
                mode = { "n" },
                desc = "Search Tags",
            },
            {
                "<leader>ofl",
                "<cmd>Obsidian links<CR>",
                mode = { "n" },
                desc = "Search Links"
            },
            {
                "<leader>ofl",
                "<cmd>Obsidian follow_link<CR>",
                mode = { "n" },
                desc = "Follow Link"
            },
            {
                "<leader>onl",
                "<cmd>Obsidian link_new<CR>",
                mode = { "n", "v" },
                desc = "New Link"
            },
            {
                "<leader>ol",
                "<cmd>Obsidian link<CR>",
                mode = { "n", "v" },
                desc = "Link"
            },
            {
                "<leader>onn",
                "<cmd>Obsidian new<CR>",
                mode = { "n" },
                desc = "New Note"
            },
        },
        after = function()
            require("obsidian").setup({
                ui = { enable = false },
                workspaces = {
                    {
                        name = "Personal",
                        path = "~/Personal/Vaults/Personal",
                        overrides = {
                            notes_subdir = "05_Fleeting",
                            attachments = {
                                img_folder = "99_Meta/01_Assets/imgs",
                            },
                        },
                    },
                    {
                        name = "Work",
                        path = "~/Personal/Vaults/Dev",
                        -- overrides = {
                        --         notes_subdir = "",
                        -- },
                    },
                    -- {
                    --     name = "Vault",
                    --     path = "~/Documents/Vault",
                    --     overrides = {
                    --         notes_subdir = "05_Fleeting",
                    --         attachments = {
                    --             img_folder = "99_Meta/01_Assets/imgs",
                    --         },
                    --     },
                    -- },
                },
                templates = {
                    folder = "99_Meta/00_Templates",
                    date_format = "%Y-%m-%d",
                    time_format = "%H:%M",
                    -- A map for custom variables, the key should be the variable and the value a function.
                    -- Functions are called with obsidian.TemplateContext objects as their sole parameter.
                    -- See: https://github.com/obsidian-nvim/obsidian.nvim/wiki/Template#substitutions
                    -- substitutions = {},

                    -- A map for configuring unique directories and paths for specific templates
                    --- See: https://github.com/obsidian-nvim/obsidian.nvim/wiki/Template#customizations
                    -- customizations = {},
                },
                daily_notes = {
                    -- Optional, if you keep daily notes in a separate directory.
                    folder = "06_Daily",
                    -- Optional, if you want to change the date format for the ID of daily notes.
                    date_format = "%Y-%m-%d",
                    -- Optional, if you want to change the date format of the default alias of daily notes.
                    alias_format = "%B %-d, %Y",
                    -- Optional, default tags to add to each new daily note created.
                    default_tags = { "daily-notes" },
                    -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
                    -- template = "daily.md",
                    -- Optional, if you want `Obsidian yesterday` to return the last work day or `Obsidian tomorrow` to return the next work day.
                    workdays_only = true,
                },
                completion = {
                    -- Enables completion using blink.cmp
                    blink = true,
                    -- Trigger completion at 2 chars.
                    min_chars = 2,
                    -- Set to false to disable new note creation in the picker
                    create_new = true,
                },
            })
        end,
    },

}
