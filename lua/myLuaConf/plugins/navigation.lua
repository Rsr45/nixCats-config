return {
        {
                "harpoon2",
                for_cat = 'general.navigation',
                after = function()
                        local harpoon = require('harpoon')

                        harpoon:setup()

                        vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
                        vim.keymap.set("n", "<C-t>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

                        vim.keymap.set("n", "<C-n>", function() harpoon:list():select(1) end)
                        vim.keymap.set("n", "<C-e>", function() harpoon:list():select(2) end)
                        vim.keymap.set("n", "<C-i>", function() harpoon:list():select(3) end)
                        vim.keymap.set("n", "<C-o>", function() harpoon:list():select(4) end)

                        -- Toggle previous & next buffers stored within Harpoon list
                        vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
                        vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
                end,
        },
        {
                "leap.nvim",
                for_cat = 'general.navigation',
                dep_of = { "flit.nvim"},
                after = function()
                        local leap = require('leap')
                        leap.set_default_mappings()
                        -- Exclude whitespace and the middle of alphabetic words from preview:
                        --   foobar[baaz] = quux
                        --   ^----^^^--^^-^-^--^
                        require('leap').opts.preview_filter =
                            function(ch0, ch1, ch2)
                                    return not (
                                            ch1:match('%s') or
                                            ch0:match('%a') and ch1:match('%a') and ch2:match('%a')
                                    )
                            end
                        require('leap').opts.equivalence_classes = { ' \t\r\n', '([{', ')]}', '\'"`' }
                        require('leap.user').set_repeat_keys('<enter>', '<backspace>')
                end,
        },
        {
                "flit.nvim",
                for_cat = 'general.navigation',
                after = function()
                        require('flit').setup {
                                labeled_modes = "nv",
                                multiline = false,
                        }
                end,
        },
}
