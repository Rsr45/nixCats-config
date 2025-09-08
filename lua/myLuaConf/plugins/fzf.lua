return {
    {
        "fzf-lua",
        for_cat = "general.always",
        cmd = { "FzfLua" },
        keys = {
            { "<leader>sf",        "<cmd>FzfLua files<CR>",    mode = { "n" }, desc = '[S]earch [F]iles', },
            { "<leader><leader>s", "<cmd>FzfLua buffers<CR>",  mode = { "n" }, desc = '[ ] Find existing buffers', },
            { "<leader>s.",        "<cmd>FzfLua oldfiles<CR>", mode = { "n" }, desc = '[S]earch Recent Files ("." for repeat)', },
            { "<leader>sr",        "<cmd>FzfLua resume<CR>",   mode = { "n" }, desc = '[S]earch [R]esume', },
            -- { "<leader>sd",        function() return require('telescope.builtin').diagnostics() end, mode = { "n" }, desc = '[S]earch [D]iagnostics', },
            { "<leader>sg",        "<cmd>FzfLua live_grep<CR>",   mode = { "n" }, desc = '[S]earch by [G]rep', },
            { "<leader>sw",        "<cmd>FzfLua grep_cword<Cr>", mode = { "n" }, desc = '[S]earch current [W]ord', },
            { "<leader>ss",        "<cmd>FzfLua<CR>",     mode = { "n" }, desc = '[S]earch [S]elect Telescope', },
            { "<leader>sk",        "<cmd>FzfLua keymaps<CR>",     mode = { "n" }, desc = '[S]earch [K]eymaps', },
            { "<leader>sh",        "<cmd>FzfLua helptags<CR>",   mode = { "n" }, desc = '[S]earch [H]elp', },
        },
    },
}
