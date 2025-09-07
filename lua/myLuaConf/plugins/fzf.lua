return {
    {
        "fzf-lua",
        for_cat = "general.always",
        cmd = { "FzfLua" },
        keys = {
            { "<leader>sf",        "<cmd>FzfLua files<CR>",    mode = { "n" }, desc = '[S]earch [F]iles', },
            { "<leader><leader>s", "<cmd>FzfLua buffers<CR>",  mode = { "n" }, desc = '[ ] Find existing buffers', },
            { "<leader>s.",        "<cmd>FzfLua oldfiles<CR>", mode = { "n" }, desc = '[S]earch Recent Files ("." for repeat)', },
            -- { "<leader>sr",        "<cmd>FzfLuafunction() return require('telescope.builtin').resume() end",      mode = { "n" }, desc = '[S]earch [R]esume', },
            -- { "<leader>sd",        function() return require('telescope.builtin').diagnostics() end, mode = { "n" }, desc = '[S]earch [D]iagnostics', },
            -- { "<leader>sg",        function() return require('telescope.builtin').live_grep() end,   mode = { "n" }, desc = '[S]earch by [G]rep', },
            -- { "<leader>sw",        function() return require('telescope.builtin').grep_string() end, mode = { "n" }, desc = '[S]earch current [W]ord', },
            -- { "<leader>ss",        function() return require('telescope.builtin').builtin() end,     mode = { "n" }, desc = '[S]earch [S]elect Telescope', },
            -- { "<leader>sk",        function() return require('telescope.builtin').keymaps() end,     mode = { "n" }, desc = '[S]earch [K]eymaps', },
            -- { "<leader>sh",        function() return require('telescope.builtin').help_tags() end,   mode = { "n" }, desc = '[S]earch [H]elp', },
        },
    },
}
