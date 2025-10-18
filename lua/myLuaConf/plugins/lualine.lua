return {
    {
        "lualine.nvim",
        for_cat = "general.always",
        -- cmd = { "" },
        event = "DeferredUIEnter",
        -- ft = "",
        -- keys = "",
        -- colorscheme = "",
        after = function()
            require("lualine").setup({
                options = {
                    icons_enabled = true,
                    theme = "auto",
                    -- theme = colorschemeName,
                    component_separators = "",
                    section_separators = "",
                },
                sections = {
                    lualine_a = {
                        {
                            'mode',
                            fmt = function(str) return str:sub(1, 3) end,
                            -- color = { fg = '#c1c1c1', bg = '', gui = '' },
                        }
                    },
                    lualine_b = {
                        {
                            "lsp_status",
                            -- color = { fg = '#c1c1c1', bg = '', gui = '' },
                        }
                    },
                    lualine_c = {
                        {
                            'filename',
                            file_status = true,     -- Displays file status (readonly status, modified status)
                            newfile_status = false, -- Display new file status (new file means no write after created)
                            path = 1,               -- 0: Just the filename
                            -- 1: Relative path
                            -- 2: Absolute path
                            -- 3: Absolute path, with tilde as the home directory
                            -- 4: Filename and parent dir, with tilde as the home directory

                            shorting_target = 40, -- Shortens path to leave 40 spaces in the window
                            -- for other components. (terrible name, any suggestions?)
                            symbols = {
                                modified = '[+]',      -- Text to show when the file is modified.
                                readonly = '[-]',      -- Text to show when the file is non-modifiable or readonly.
                                unnamed = '[No Name]', -- Text to show for unnamed buffers.
                                newfile = '[New]',     -- Text to show for newly created file before first write
                            },
                            -- color = { fg = '#c1c1c1', bg = '', gui = '' },
                        },
                    },
                    lualine_x = {
                        {
                            -- color = { fg = '#c1c1c1', bg = '', gui = '' },
                        }
                    },
                    lualine_y = {
                        {
                            -- "progress",
                            -- color = { fg = '#c1c1c1', bg = '', gui = '' },
                        },
                    },
                    lualine_z = {
                        {
                            "location",
                            -- color = { fg = '#c1c1c1', bg = '', gui = '' },
                        }
                    }
                },
                inactive_sections = {
                    lualine_a = {
                        {
                            'mode',
                            fmt = function(str) return str:sub(1, 3) end,
                            -- color = { fg = '#c1c1c1', bg = '', gui = '' },
                        }
                    },
                    lualine_b = {
                        {
                            "lsp_status",
                            -- color = { fg = '#c1c1c1', bg = '', gui = '' },
                        }
                    },
                    lualine_c = {
                        {
                            'filename',
                            file_status = true,     -- Displays file status (readonly status, modified status)
                            newfile_status = false, -- Display new file status (new file means no write after created)
                            path = 1,               -- 0: Just the filename
                            -- 1: Relative path
                            -- 2: Absolute path
                            -- 3: Absolute path, with tilde as the home directory
                            -- 4: Filename and parent dir, with tilde as the home directory

                            shorting_target = 40, -- Shortens path to leave 40 spaces in the window
                            -- for other components. (terrible name, any suggestions?)
                            symbols = {
                                modified = '[+]',      -- Text to show when the file is modified.
                                readonly = '[-]',      -- Text to show when the file is non-modifiable or readonly.
                                unnamed = '[No Name]', -- Text to show for unnamed buffers.
                                newfile = '[New]',     -- Text to show for newly created file before first write
                            },
                            -- color = { fg = '#c1c1c1', bg = '', gui = '' },
                        },
                    },
                    lualine_x = {
                        {
                            -- color = { fg = '#c1c1c1', bg = '', gui = '' },
                        }
                    },
                    lualine_y = {
                        {
                            -- "progress",
                            -- color = { fg = '#c1c1c1', bg = '', gui = '' },
                        },
                    },
                    lualine_z = {
                        {
                            "location",
                            -- color = { fg = '#c1c1c1', bg = '', gui = '' },
                        }
                    }
                },
                -- winbar = {
                --     lualine_a = {
                --         {
                --             "filename",
                --             -- color = { fg = '#c1c1c1', bg = '', gui = '' },
                --         },
                --     },
                --     lualine_b = {
                --         {
                --             function()
                --                 return require('nvim-navic').get_location()
                --             end,
                --             cond = function()
                --                 return require('nvim-navic').is_available()
                --             end,
                --
                --             -- color = { fg = '#c1c1c1', bg = '', gui = '' },
                --         },
                --     },
                --     lualine_c = {},
                --     lualine_x = {},
                --     lualine_y = {},
                --     lualine_z = {},
                -- },
                -- inactive_winbar = {
                --     lualine_a = {
                --         {
                --             "filename",
                --             -- color = { fg = '#c1c1c1', bg = '', gui = '' },
                --         },
                --     },
                --     lualine_b = {
                --         {
                --             function()
                --                 return require('nvim-navic').get_location()
                --             end,
                --             cond = function()
                --                 return require('nvim-navic').is_available()
                --             end,
                --
                --             -- color = { fg = '#c1c1c1', bg = '', gui = '' },
                --         },
                --     },
                --     lualine_c = {},
                --     lualine_x = {},
                --     lualine_y = {},
                --     lualine_z = {},
                -- },
            })
        end,
    },
}
