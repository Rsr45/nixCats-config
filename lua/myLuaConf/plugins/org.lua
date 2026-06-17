return {
    {
        "orgmode",
        for_cat = "org",
        ft = "org",
        dep_of = { "org-roam.nvim", "org-bullets", "org-modern" },
        cmd = { "Org" },
        lazy = false,
        after = function()
            local Menu = require("org-modern.menu")

            require("orgmode").setup({
                org_agenda_files = "~/Documents/Notes/**/*",
                org_default_notes_file = "~/Documents/Notes/refile.org",
                org_adapt_indentation = false,
                org_startup_indented = true,

                ui = {
                    menu = {
                        handler = function(data)
                            Menu:new({
                                window = {
                                    margin = { 1, 0, 1, 0 },
                                    padding = { 0, 1, 0, 1 },
                                    title_pos = "center",
                                    border = "single",
                                    zindex = 1000,
                                },
                                icons = {
                                    separator = "->",
                                },
                            }):open(data)
                        end,
                    },
                },
            })
        end,
    },
    {
        "org-roam.nvim",
        for_cat = "org",
        ft = "org",
        lazy = false,
        cmd = { "Org" },
        after = function()
            require("org-roam").setup({
                directory = "~/Documents/Notes/roam",

                -- hyperlinks = {
                --     sources = {
                --       require("denote.extensions.orgmode"):new({
                --         files = vim.g.denote.directory
                --       }),
                --     },
                --   },
            })
        end,
    },
    {
        "org-bullets",
        for_cat = "org",
        ft = "org",
        -- lazy = false,
        after = function()
            require("org-bullets").setup()
        end,
    },
    {
        "org-modern",
        for_cat = "org",
        dep_of = { "orgmode" },
        ft = "org",
        -- lazy = false,
        after = function()
        end,
    },
}
