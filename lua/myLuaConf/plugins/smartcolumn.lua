return {
    {
        "smartcolumn.nvim",
        for_cat = "general.always",
        after = function()
            require("smartcolumn").setup({})
        end
    },
}
