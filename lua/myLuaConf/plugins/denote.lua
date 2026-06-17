return {
    {
        "denote",
        for_cat = "notes",
        cmd = { "Denote",
            "Denote rename-file",
            "Denote rename-file-title",
            "Denote rename-file-keywords",
            "Denote rename-file-signature",
            "Denote backlinks", },
        keys = {
            { "<leader>dd", mode = "n", "<cmd>Denote<CR>", desc = "New Note", },
            { "<leader>dr", mode = "n", "<cmd>Denote<CR>", desc = "New Note", },
        },
        lazy = false,
        -- dep_of = { "org-roam.nvim" },
        after = function()
            ---@class Denote.Integrations.Telescope.Configuration
            ---@field enabled boolean
            ---@field opts table?

            ---@class Denote.Integrations.Configuration
            ---@field oil boolean Activate `stevearc/oil.nvim` extension
            ---@field telescope boolean|Denote.Integrations.Telescope.Configuration

            ---@class Denote.Configuration
            ---@field filetype string? Default note file type
            ---@field directory string? Denote files directory
            ---@field prompts string[]? File creation/renaming prompt order
            ---@field integrations Denote.Integrations.Configuration? Extensions configuration

            --@type Denote.Configuration
            require("denote").setup({
                filetype = "markdown-toml",
                directory = "~/Documents/denote/",
                prompts = { "title", "keywords" },
                integrations = {
                    oil = true,
                    telescope = false,
                },
            })
        end
    }
}
