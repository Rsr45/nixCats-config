return {
    {
        "mini.pick",
        for_cat = "general.filesystem",
        -- cmd = { "Pick" },
        keys = {
            { "<leader>/",        mode = { "n" }, "<cmd>lua MiniPick.builtin.grep()<CR>",                 desc = "Grep", },
            { "<leader>,",        mode = { "n" }, "<cmd>lua MiniPick.builtin.buffers()<CR>",              desc = "Switch buffer", },
            { "<leader>.",        mode = { "n" }, "<cmd>lua MiniPick.builtin.files({ tool = 'fd' })<CR>", desc = "Find File", },
            { "<leader><leader>", mode = { "n" }, "<cmd>lua MiniPick.builtin.files({ tool = 'fd' })<CR>", desc = "Find File", },
            { "<leader>ff",       mode = { "n" }, "<cmd>lua MiniPick.builtin.files({ tool = 'fd' })<CR>", desc = "Find File", },
        },
        lazy = false,
        after = function()
            require("mini.pick").setup()
        end
    },
    {
        "mini.files",
        for_cat = "general.filesystem",
        lazy = false,
        -- cmd = { "Pick" },
        -- keys = { { "" }
        -- },
        after = function()
            require("mini.files").setup()
        end
    }
}
