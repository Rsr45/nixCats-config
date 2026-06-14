return {
    {
        "neorg",
        for_cat = "notes",
        ft = "norg",
        cmd = "Neorg",
        lazy = false,
        after = function()
            -- local dirman = require('neorg').modules.get_module("core.dirman")
            -- dirman.create_file("my_file", "default", {
            --     no_open  = false, -- open file after creation?
            --     force    = false, -- overwrite file if exists
            --     metadata = {}     -- key-value table for metadata fields
            -- })

            vim.keymap.set("n", "<leader>nrn", "<Plug>(neorg.dirman.new-note)", {})

            require("neorg").setup({
                load = {
                    ["core.defaults"] = {},
                    ["core.keybinds"] = {
                        config = {
                            default_keybinds = false,
                        },
                    },
                    ["core.concealer"] = {
                        config = {
                            icon_preset = "diamond",
                        }
                    },
                    ["core.dirman"] = {
                        config = {
                            workspaces = {
                                personal = "~/Documents/Notes/",
                            },
                            default_workspace = "personal",
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
