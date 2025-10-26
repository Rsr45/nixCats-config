return {
    {
        "noice.nvim",
        for_cat = "general.always",
        lazy = false,
        after = function()
            require("noice").setup({
                lsp = {
                    override = {
                        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        -- override the lsp markdown formatter with Noice
                        ["vim.lsp.util.stylize_markdown"] = true,
                        -- override cmp documentation with Noice (needs the other options to work)
                        -- ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
                    },

                    signature = {
                        enabled = false,
                        auto_open = {
                            enabled = false,
                            trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
                            luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
                            throttle = 50,  -- Debounce lsp signature help request by 50ms
                        },
                    },
                    documentation = {},
                    hover = {},
                    progress = {
                        enabled = false,
                    },
                },

                cmdline = {
                    format = {
                        cmdline = { icon = ">" },
                        search_down = { icon = "🔍⌄" },
                        search_up = { icon = "🔍⌃" },
                        filter = { icon = "$" },
                        lua = { icon = "☾" },
                        help = { icon = "?" },
                    },
                },
                format = {
                    level = {
                        icons = {
                            error = "✖",
                            warn = "▼",
                            info = "●",
                        },
                    },
                },
                popupmenu = {
                    kind_icons = false,
                },
                inc_rename = {
                    cmdline = {
                        format = {
                            IncRename = { icon = "⟳" },
                        },
                    },
                },

                notify = {
                    enabled = true,
                    view = "notify",
                },

                -- popupmenu = {
                --     backend = "cmp",
                -- },
                -- you can enable a preset for easier configuration
                presets = {
                    bottom_search = false,        -- use a classic bottom cmdline for search
                    command_palette = false,      -- position the cmdline and popupmenu together
                    long_message_to_split = true, -- long messages will be sent to a split
                    inc_rename = false,           -- enables an input dialog for inc-rename.nvim
                    lsp_doc_border = false,       -- add a border to hover docs and signature help
                },
                views = {
                    cmdline_popup = {
                        border = {
                            style = "single",
                            -- padding = { 0, 1 },
                        },
                    },
                    popupmenu = {
                        border = {
                            style = "single",
                            -- padding = { 0, 1 },
                        },
                    },
                    mini = {
                        border = {
                            style = "single",
                            -- padding = { 0, 1 },
                        },
                    },
                    hover = {
                        border = {
                            style = "single",
                            -- padding = { 0, 1 },
                        },
                    },
                    popup = {
                        border = {
                            style = "single",
                            -- padding = { 0, 1 },
                        },
                    },
                    split = {
                        scrollbarSet = false,
                    },
                    notify = {
                        border = {
                            style = "single",
                            -- padding = { 0, 1 },
                        },
                    },
                    -- messages = {
                    --     border = {
                    --         style = "single",
                    --         -- padding = { 0, 1 },
                    --     },
                    -- },
                    -- virtualtext = {
                    --     border = {
                    --         style = "single",
                    --         -- padding = { 0, 1 },
                    --     },
                    -- },
                },
            })
        end,
    },
}
