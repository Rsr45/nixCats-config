return {
    {
        "mini.comment",
        for_cat = "general.mini",
        event = "DeferredUIEnter",
        after = function()
            require("mini.comment").setup()
        end,
    },
    {
        "mini.surround",
        for_cat = "general.mini",
        event = "DeferredUIEnter",
        after = function()
            require("mini.surround").setup({
                mappings = {
                    add = "gsa",            -- Add surrounding in Normal and Visual modes
                    delete = "gsd",         -- Delete surrounding
                    find = "gsf",           -- Find surrounding (to the right)
                    find_left = "gsF",      -- Find surrounding (to the left)
                    highlight = "gsh",      -- Highlight surrounding
                    replace = "gsr",        -- Replace surrounding
                    update_n_lines = "gsn", -- Update `n_lines`
                },
                -- keys = {
                --     { "gs", "", desc = "+surround" },
                -- },
            })
        end,
    },
    {
        "mini.ai",
        for_cat = "general.mini",
        event = "DeferredUIEnter",
        after = function()
            require("mini.ai").setup()
        end
    },
    {
        "mini.pairs",
        for_cat = "general.mini",
        after = function()
            require("mini.pairs").setup()
        end,
    },
    {
        "mini.operators",
        for_cat = "general.mini",
        after = function()
            require("mini.operators").setup()
        end,
    },
    {
        "mini.bracketed",
        for_cat = "general.mini",
        after = function()
            require("mini.bracketed").setup()
        end,
    },
    {
        "mini.bufremove",
        for_cat = "general.mini",
        keys = {
            { "<leader>bd", mode = { "n" }, "<cmd>lua MiniBufremove.delete()<CR>", desc = "Kill buffer" },
            { "<leader>bk", mode = { "n" }, "<cmd>lua MiniBufremove.delete()<CR>", desc = "Kill buffer" },
        },
        after = function()
            require("mini.bufremove").setup()
        end,
    },
    {
        "mini.align",
        for_cat = "general.mini",
        after = function()
            require("mini.align").setup({
                mappings = {
                    left = '<M-left>',
                    right = '<M-right>',
                    down = '<M-down>',
                    up = '<M-up>',

                    line_left = '<M-left>',
                    line_right = '<M-right>',
                    line_down = '<M-down>',
                    line_up = '<M-up>',
                },
            })
        end,
    },
    -- {
    --     "mini.indentscope",
    --     for_cat = "general.mini",
    --     after = function()
    --         require("mini.indentscope").setup({
    --             draw = {
    --                 animation = require('mini.indentscope').gen_animation.none(),
    --             },
    --             symbol = "┆",
    --             options = {
    --                 try_as_border = true,
    --             },
    --         })
    --         -- neopywal fix
    --         vim.cmd([[hi! link MiniIndentscopeSymbol ModeMsg]])
    --     end
    -- },
    {
        "mini.cursorword",
        for_cat = "general.mini",
        after = function()
            require("mini.cursorword").setup()
        end
    },
    {
        "mini.extra",
        for_cat = "general.mini",
        after = function()
            require("mini.extra").setup()
        end
    },
    {
        "mini.diff",
        for_cat = "general.mini",
        after = function()
            require("mini.diff").setup()
        end
    }
}
