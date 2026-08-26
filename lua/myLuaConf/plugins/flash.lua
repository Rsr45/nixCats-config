return {
    {
        "flash.nvim",
        for_cat = "general.extra",
        event = "DeferredUIEnter",
        keys = {
            { "<Return>", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
            -- { "r", mode = "o",               function() require("flash").remote() end, desc = "Remote Flash" },
            -- { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            -- { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
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
