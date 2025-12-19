return {
    {
        "mini.statusline",
        for_cat = "general.mini",
        event = "DeferredUIEnter",
        after = function()
            require("mini.statusline").setup({
                -- content = {
                --     active = {},
                --     inactive = {},
                -- },
            })
        end,
    },
}
