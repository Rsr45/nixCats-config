return {
    {
        "vim-fugitive",
        for_cat = "general.always",
        cmd = { "G", "Git" },
        keys = {
            { "<leader>ga", mode = { "n" }, "<cmd>Git add %:p<CR>", desc = "Add" },
        },
    }
}
