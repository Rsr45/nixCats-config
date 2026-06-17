return {
    {
        "nvim-ufo",
        for_cat = "general.extra",
        lazy = false,
        event = "BufReadPost",
        after = function()
            vim.o.foldcolumn = "0"
            vim.o.foldlevel = 99
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true

            vim.keymap.set("n", "zR", require("ufo").openAllFolds)
            vim.keymap.set("n", "zM", require("ufo").closeAllFolds)

            require("ufo").setup({
                provide_selector = function(bufnr, filetype, buftype)
                    return { "lsp", "treesitter", "indent" }
                end,
            })
        end,
    },
}
