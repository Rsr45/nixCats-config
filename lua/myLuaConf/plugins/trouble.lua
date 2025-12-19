return {
    {
        "trouble.nvim",
        for_cat = "general.always",
        lazy = false,
        after = function()
            require("trouble").setup()
        end
    }
}
