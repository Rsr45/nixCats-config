return {
    {
        "neorg",
        for_cat = "notes",
        ft = "norg",
        cmd = "Neorg",
        lazy = false,
        after = function()
            require("neorg").setup({
                load = {
                    ["core.defaults"] = {},
                    ["core.concealer"] = {
                        config = {
                            icon_preset = "diamond",
                        }
                    },
                    ["core.dirman"] = {
                        config = {
                            workspaces = {
                                default = "~/Personal/Notes/",
                            },
                        },
                    },
                    -- ["core.latex.renderer"] = {},
                    ["core.tangle"] = {},
                    ["core.qol.toc"] = {},
                    ["core.export"] = {},
                    ["core.export.html"] = {},
                    ["core.export.markdown"] = {
                        config = {
                            extensions = "all",
                        }
                    },
                }
            })
        end,
    },
}
