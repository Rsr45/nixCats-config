return {
    {
        "mini.statusline",
        for_cat = "general.always",
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
