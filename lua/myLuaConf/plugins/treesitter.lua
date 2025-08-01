-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
return {
    {
        "nvim-treesitter",
        for_cat = 'general.treesitter',
        -- cmd = { "" },
        event = "DeferredUIEnter",
        -- ft = "",
        -- keys = "",
        -- colorscheme = "",
        load = function(name)
            vim.cmd.packadd(name)
            vim.cmd.packadd("nvim-treesitter-textobjects")
        end,
        after = function(plugin)
            -- [[ Configure Treesitter ]]
            -- See `:help nvim-treesitter`
            require('nvim-treesitter.configs').setup {
                highlight = { enable = true, },
                indent = { enable = false, },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = '<c-space>',
                        node_incremental = '<c-space>',
                        scope_incremental = '<c-s>',
                        node_decremental = '<M-space>',
                    },
                },
                textobjects = {
                    select = {
                        enable = false,
                        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                        keymaps = {
                            -- You can use the capture groups defined in textobjects.scm
                            ['aa'] = '@parameter.outer',
                            ['ia'] = '@parameter.inner',
                            ['af'] = '@function.outer',
                            ['if'] = '@function.inner',
                            ['ac'] = '@class.outer',
                            ['ic'] = '@class.inner',
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true, -- whether to set jumps in the jumplist
                        goto_next_start = {
                            [']m'] = '@function.outer',
                            [']]'] = '@class.outer',
                        },
                        goto_next_end = {
                            [']M'] = '@function.outer',
                            [']['] = '@class.outer',
                        },
                        goto_previous_start = {
                            ['[m'] = '@function.outer',
                            ['[['] = '@class.outer',
                        },
                        goto_previous_end = {
                            ['[M'] = '@function.outer',
                            ['[]'] = '@class.outer',
                        },
                    },
                    swap = {
                        enable = true,
                        swap_next = {
                            ['<leader>la'] = '@parameter.inner',
                        },
                        swap_previous = {
                            ['<leader>lA'] = '@parameter.inner',
                        },
                    },
                },
            }
        end,
    },
}
