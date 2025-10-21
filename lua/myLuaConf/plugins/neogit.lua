return {
    {
        "neogit",
        for_cat = "general.git",
        cmd = { "Neogit" },
        keys = {
            { "<leader>gg", "<cmd>Neogit<Cr>", mode = { "n" }, desc = "Open Neogit" },
        },
        after = function()
            require("neogit").setup({})
        end
    },
}
