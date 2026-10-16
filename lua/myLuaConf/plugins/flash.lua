return {
    {
        "flash.nvim",
        for_cat = "general.extra",
        lazy = false,
        -- event = "DeferredUIEnter",
        keys = {
            { "<Return>", mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
            -- { "sn",        mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
        },
        after = function()
            require("flash").setup({
                -- labels = "asdfghjklqwertyuiopzxcvbnm",
                -- labels = 'arstgmneio', -- colemak
                labels = 'strdnaei', -- sturdy
                label = {
                    uppercase = false,
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
                -- highlight = { matches = false, },
            })
        end,
    },
}
