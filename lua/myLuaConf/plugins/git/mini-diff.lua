return {
    {
        "mini.diff",
        for_cat = "general.git",
        after = function()
            require("mini.diff").setup()
        end
    }
}
