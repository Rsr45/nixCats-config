return {
    {
        "neorg",
        for_cat = "notes",
        ft = "norg",
        lazy = false,
        after = function ()
            require("neorg").setup({})
        end,
    },
}
