return {
    {
        "lualine.nvim",
        for_cat = "general.always",
        event = "DeferredUIEnter",
        after = function()
            vim.o.laststatus = 3
            require("lualine").setup({
                options = {
                    component_separators = { left = "|", right = "|" },
                    section_separators = { left = "", right = "" },
                    disabled_filetypes = { "snacks_dashboard" },
                },
                sections = {
                    lualine_a = {
                        "mode",
                    },
                    lualine_b = {
                        "branch",
                        "diff",
                        "diagnostics",
                        {
                            "buffers",
                            buffers_color = {
                                active = 'CurSearch',
                                inactive = { gui = "italic" },
                            },
                            symbols = {
                                modified = " ●",
                                alternate_file = "",
                                directory = "",
                            },
                            mode = 2,
                        },
                    },
                    lualine_c = {
                        {
                            "filename",
                            file_status = true,
                            path = 3,
                        },
                    },
                    lualine_x = {
                        "filesize",
                    },
                    lualine_y = {
                        "searchcount",
                        "selectioncount",
                        "lsp_status",
                        "filetype",
                    },
                    lualine_z = {
                        "encoding",
                        "location",
                    },
                },
            })
        end,
    }
}
