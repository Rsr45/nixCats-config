return {
    {
        "mini.base16",
        for_cat = "general.extra",
        lazy = false,
        after = function()
            require('mini.base16').setup({
                palette = nixCats.extra("base16colors"),
                use_cterm = true,
                plugins = {
                    default = true,
                },
            })
        end,
    }
}
