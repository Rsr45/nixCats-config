return {
    {
        "neogit",
        for_cat = "general.git",
        cmd = { "Neogit" },
        keys = {
            { "<leader>gg", "<cmd>Neogit<Cr>",      mode = { "n" }, desc = "Neogit" },
            { "<leader>gp", "<cmd>Neogit push<Cr>", mode = { "n" }, desc = "Push" },
            { "<leader>gc", "<cmd>Neogit commit<Cr>", mode = { "n" }, desc = "Commit" },
        },
        after = function()
            require("neogit").setup({
                kind = "split_below",
            })
        end
    },
}
