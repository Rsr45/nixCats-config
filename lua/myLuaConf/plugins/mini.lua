return {
    -- {
    --     "mini.base16",
    --     for_cat = "general.always",
    --     event = "DeferredUIEnter",
    -- },
    {
        "mini.comment",
        for_cat = "general.extra",
        event = "DeferredUIEnter",
        after = function()
            require("mini.comment").setup()
        end,
    },
    {
        "mini.surround",
        for_cat = "general.always",
        event = "DeferredUIEnter",
        after = function()
            require("mini.surround").setup({
                mappings = {
                    add = "gza",            -- Add surrounding in Normal and Visual modes
                    delete = "gzd",         -- Delete surrounding
                    find = "gzf",           -- Find surrounding (to the right)
                    find_left = "gzF",      -- Find surrounding (to the left)
                    highlight = "gzh",      -- Highlight surrounding
                    replace = "gzr",        -- Replace surrounding
                    update_n_lines = "gzn", -- Update `n_lines`
                },
                keys = {
                    { "gz", "", desc = "+surround" },
                },
            })
        end,
    },
    {
        "mini.ai",
        for_cat = "general.always",
        event = "DeferredUIEnter",
        after = function()
            require("mini.ai").setup({})
        end
    },
    {
        "mini.pairs",
        for_cat = "general.always",
        after = function()
            require("mini.pairs").setup()
        end,
    },
    {
        "mini.operators",
        for_cat = "general.always",
        after = function()
            require("mini.operators").setup()
        end,
    },
    {
        "mini.bracketed",
        for_cat = "general.always",
        after = function()
            require("mini.bracketed").setup()
        end,
    },
    {
        "mini.icons",
        for_cat = "general.extra",
        after = function()
            require("mini.icons").setup()
            MiniIcons.mock_nvim_web_devicons()
        end,
    },
    -- {
    --     "mini.statusline",
    --     for_cat = "general.always",
    --     event = "DeferredUIEnter",
    --     after = function()
    --         require("mini.statusline").setup()
    --     end,
    -- },
}
