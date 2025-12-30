return {
    {
        "which-key.nvim",
        for_cat = "general.extra",
        event = "DeferredUIEnter",
        after = function()
            require("which-key").setup({
                preset = "helix",
                win = {
                    border = "none",
                },
                icons = {
                    breadcrumb = " ";
                    separator = ":";
                },
            })
            require("which-key").add({
                { "<leader>t",  group = "toggle" },
                { "<leader>t_", hidden = true },
                { "<leader>s",  group = "search" },
                { "<leader>s_", hidden = true },
                { "<leader>o",  group = "open" },
                { "<leader>o_", hidden = true },
                { "<leader>n",  group = "notes" },
                { "<leader>n_", hidden = true },
                { "<leader>f",  group = "file" },
                { "<leader>f_", hidden = true },
                { "<leader>b",  group = "buffer" },
                { "<leader>b_", hidden = true },
                { "<leader>g",  group = "git" },
                { "<leader>g_", hidden = true },
                { "<leader>c",  group = "code" },
                { "<leader>c_", hidden = true },
                { "<leader>d",  group = "debug" },
                { "<leader>d_", hidden = true },
                { "<leader>m",  group = "markdown" },
                { "<leader>m_", hidden = true },
                { "<leader>r",  group = "rename" },
                { "<leader>r_", hidden = true },
                { "<leader>w",  group = "workspace" },
                { "<leader>w_", hidden = true },
                { "<leader>l",  group = "lsp" },
                { "<leader>l_", hidden = true },
            })
        end,
    },
}
