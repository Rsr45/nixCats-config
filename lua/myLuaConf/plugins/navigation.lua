return {
    {
        "harpoon2",
        for_cat = "general.navigation",
        after = function()
            local harpoon = require("harpoon")

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
    -- {
    --     "mini.jump",
    --     for_cat = "general.navigation",
    --     event = "DeferredUIEnter",
    --     after = function()
    --         require("mini.jump").setup()
    --     end
    -- },
    -- {
    --     "mini.jump2d",
    --     for_cat = "general.navigation",
    --     event = "DeferredUIEnter",
    --     after = function()
    --         local user_input_opts = function(input_fun) -- Copied
    --             local res = {
    --                 spotter = function() return {} end,
    --                 allowed_lines = { blank = false, fold = false },
    --             }
    --
    --             res.hooks = {
    --                 before_start = function()
    --                     local input = input_fun()
    --                     if input ~= nil then res.spotter = MiniJump2d.gen_spotter.pattern(vim.pesc(input)) end
    --                 end,
    --             }
    --             return res
    --         end
    --
    --         local getleapedstr = function(msg) -- gets two chars
    --             local _, char1 = pcall(vim.fn.getcharstr)
    --             local _, char2 = pcall(vim.fn.getcharstr)
    --
    --             return char1 .. char2
    --         end
    --
    --         local start = function() -- two chars, based on MiniJump2d.builtin_opts.single_character
    --             local leaped = user_input_opts(function() return getleapedstr() end)
    --             MiniJump2d.start(leaped)
    --         end
    --
    --         -- vim.keymap.set({ "n", "x" }, "s", "<Nop>", { desc = "Start 2d jumping" })
    --         -- No repeat in operator pending mode... See mini.jump2d H.apply_config.
    --         vim.keymap.set({ "n", "x", "o" }, "s", start, { desc = "Start 2d jumping" })
    --
    --         require("mini.jump2d").setup({
    --             -- labels = 'abcdefghijklmnopqrstuvwxyz',
    --             labels = 'arstgmneio',
    --
    --             allowed_lines = {
    --                 blank = false,     -- type j/k after the jump, or use paragraph motions...
    --                 cursor_at = false, -- use fFtT on current line.
    --             },
    --             view = { dim = true, n_steps_ahead = 1 },
    --             mappings = {
    --                 start_jumping = '',
    --             },
    --         })
    --     end
    -- },
    {
        "flash.nvim",
        for_cat = "general.navigation",
        event = "DeferredUIEnter",
        keys = {
            { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
            {
                "S",
                mode = { "n", "x", "o" },
                function()
                    require("flash").treesitter({
                        actions = {
                            ["S"] = "next", ["s"] = "prev", ["<RETURN>"] = "next", ["<BS>"] = "prev",
                        }
                    })
                end,
                desc = "Flash Treesitter"
            },
            -- {
            --     "s",
            --     function()
            --         local Flash = require("flash")
            --
            --         -- for the first match
            --         ---@param opts Flash.Format
            --         local function format1(opts)
            --             return {
            --                 { opts.match.label1, "FlashLabel" },
            --                 { opts.match.label2, "FlashMatch" },
            --             }
            --         end
            --
            --         -- for the second match
            --         ---@param opts Flash.Format
            --         local function format2(opts)
            --             return {
            --                 { opts.match.label1, "FlashBackdrop" }, -- will be hidden
            --                 { opts.match.label2, "FlashLabel" },
            --             }
            --         end
            --
            --         Flash.jump({
            --             search = { mode = "search" },
            --             highlight = { matches = false },
            --             label = { format = format1 },
            --             ---@type fun(match:Flash.Match, state:Flash.State)|nil
            --             action = function(match, state)
            --                 state:hide()
            --                 Flash.jump({
            --                     search = { max_length = 0 },
            --                     highlight = { matches = false },
            --                     label = { format = format2 },
            --                     matcher = function(win)
            --                         -- limit matches to the current label
            --                         return vim.tbl_filter(function(m)
            --                             return m.label == match.label and m.win == win
            --                         end, state.results)
            --                     end,
            --                     labeler = function(matches)
            --                         for _, m in ipairs(matches) do
            --                             m.label = m.label2 -- use the second label
            --                         end
            --                     end,
            --                 })
            --             end,
            --             labeler = function(matches, state)
            --                 local labels = state:labels()
            --                 for index, match in ipairs(matches) do
            --                     match.label1 = labels[math.floor((index - 1) / #labels) + 1]
            --                     match.label2 = labels[(index - 1) % #labels + 1]
            --                     match.label = match.label1 -- use the first label
            --                 end
            --             end,
            --         })
            --     end,
            --     mode = { "n", "x", "o" },
            --     desc = "Flash",
            -- },
            -- { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
            -- { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            -- { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
        },
        after = function()
            require("flash").setup({
                -- labels = "asdfghjklqwertyuiopzxcvbnm",
                labels = 'arstgmneio',
                label = {
                    uppercase = true,
                    distance = false,
                    -- after = false,
                    -- before = { 0, 0 },
                },
                modes = {
                    char = {
                        jump_labels = true,
                        multi_line = false,
                    },
                },
                prompt = {
                    enabled = false,
                },
                highlight = { matches = false, },
            })
            vim.keymap.set({ "n", "x", "o" }, "<c-space>", function()
                require("flash").treesitter({
                    actions = {
                        ["<c-space>"] = "next",
                        ["<BS>"] = "prev",
                        ["<RETURN>"] = "next",
                    }
                })
            end, { desc = "Treesitter incremental selection" })
        end,
    },
    -- {
    --     "leap.nvim",
    --     for_cat = 'general.navigation',
    --     dep_of = { "flit.nvim" },
    --     after = function()
    --         local leap = require('leap')
    --         leap.set_default_mappings()
    --         -- Exclude whitespace and the middle of alphabetic words from preview:
    --         --   foobar[baaz] = quux
    --         --   ^----^^^--^^-^-^--^
    --         require('leap').opts.preview_filter =
    --             function(ch0, ch1, ch2)
    --                 return not (
    --                     ch1:match('%s') or
    --                     ch0:match('%a') and ch1:match('%a') and ch2:match('%a')
    --                 )
    --             end
    --         require('leap').opts.equivalence_classes = { ' \t\r\n', '([{', ')]}', '\'"`' }
    --         require('leap.user').set_repeat_keys('<enter>', '<backspace>')
    --         vim.keymap.set({ 'x', 'o' }, 'R', function()
    --             require('leap.treesitter').select {
    --                 -- To increase/decrease the selection in a clever-f-like manner,
    --                 -- with the trigger key itself (vRRRRrr...). The default keys
    --                 -- (<enter>/<backspace>) also work, so feel free to skip this.
    --                 opts = require('leap.user').with_traversal_keys('R', 'r')
    --             }
    --         end)
    --         -- vim.keymap.set({ 'n', 'x', 'o' }, 'gs', function()
    --         -- vim.keymap.set({ 'o' }, 'r', function()
    --         --     require('leap.remote').action()
    --         -- end)
    --     end,
    -- },
    -- {
    --     "flit.nvim",
    --     for_cat = 'general.navigation',
    --     after = function()
    --         require('flit').setup {
    --             labeled_modes = "nv",
    --             multiline = false,
    --         }
    --     end,
    -- },
}
