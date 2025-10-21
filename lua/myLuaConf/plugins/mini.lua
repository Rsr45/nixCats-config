return {
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
                    add = "gsa",            -- Add surrounding in Normal and Visual modes
                    delete = "gsd",         -- Delete surrounding
                    find = "gsf",           -- Find surrounding (to the right)
                    find_left = "gsF",      -- Find surrounding (to the left)
                    highlight = "gsh",      -- Highlight surrounding
                    replace = "gsr",        -- Replace surrounding
                    update_n_lines = "gsn", -- Update `n_lines`
                },
                keys = {
                    { "gs", "", desc = "+surround" },
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
}
