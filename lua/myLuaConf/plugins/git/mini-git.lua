return {
    {
        "mini-git",
        for_cat = "general.git",
        event = "DeferredUIEnter",
        after = function()
            require("mini.git").setup()
        end,
    }
}
