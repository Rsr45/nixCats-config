return {
    {
        "trouble.nvim",
        for_cat = "general.extra",
        lazy = false,
        after = function()
            require("trouble").setup()
        end
    }
}
