return {
    {
        "obsidian.nvim",
        ft = "markdown",
        for_cat = "notes",
        cmd = { "Obsidian", "Obsidian open", "Obsidian new", "Obsidian search", "Obsidian tags", "Obsidian follow_link", "Obsidian link_new" },
        keys = {
            { "<leader>vf", mode = { "n" }, "<cmd>Obsidian quick_switch<CR>", desc = "(F)ind" },
            { "<leader>vc", mode = { "n" }, "<cmd>Obsidian new<CR>",          desc = "(C)reate" },
            { "<leader>vs", mode = { "n" }, "<cmd>Obsidian search<CR>",       desc = "(S)earch" },
            { "<leader>vt", mode = { "n" }, "<cmd>Obsidian tags<CR>",         desc = "(T)ags" },
            -- { "<leader>vlf", mode = { "n" },      "<cmd>Obsidian follow_link<CR>",  desc = "(L)ink (F)ollow" },
            -- { "<leader>vlc", mode = { "v", "x" }, "<cmd>Obsidian link_new<CR>",     desc = "(L)ink (C)reate" },
        },
        after = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "markdown",
                callback = function()
                    vim.keymap.set({ "v", "x" }, "<leader>vlc", "<cmd>Obsidian link_new<CR>")
                end,
            })
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "markdown",
                callback = function()
                    vim.keymap.set("n", "<leader>vlf", "<cmd>Obsidian follow_link<CR>")
                end,
            })

            require("obsidian").setup({
                ui = { enable = false },
                legacy_commands = false,
                -- Optional, customize how note IDs are generated given an optional title.
                ---@param title string|?
                ---@return string
                note_id_func = function(title)
                    -- Create note IDs in a Zettelkasten format with a datetime and a suffix.
                    -- In this case a note with the title 'My new note' inside folder named 'VIM' will be given an ID that looks
                    -- like '202502132345-FRXT-VIM-my_new_note', and therefore the file name '202502132345-FRXT-VIM-my_new_note.md'.
                    local suffix = ""
                    if title ~= nil then
                        suffix = suffix ..
                            "-" ..
                            title:gsub(" ", "-"):gsub("[^A-Za-z0-9_-]", ""):lower()
                    else
                        suffix = suffix ..
                            "-" ..
                            title:gsub(" ", "-"):gsub("[^A-Za-z0-9_-]", ""):lower()
                    end
                    return tostring(os.date("%Y%m%dT%H%M%S")) .. "-" .. suffix
                end,

                frontmatter = {
                    func = function(note)
                        local out = {
                            date = tostring(os.date("%Y-%m-%dT%H:%M:%S%z"):gsub("([+-]%d%d)(%d%d)$", "%1:%2")),
                            identifier =
                                os.date("%Y%m%dT%H%M%S"),
                            tags = note.tags,
                            title = note.title
                        }
                        if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
                            for k, v in pairs(note.metadata) do
                                out[k] = v
                            end
                        end

                        return out
                    end,

                    sort = { "title", "date", "tags", "identifier" },
                },
                workspaces = {
                    {
                        name = "Personal",
                        path = "~/Documents/Notes",
                        overrides = {
                            notes_subdir = "temp",
                            attachments = {
                                folder = "99_Meta/01_Attachments/imgs",
                            },
                        },
                    },
                },
                templates = {
                    folder = "99_Meta/00_Templates",
                    date_format = "%Y-%m-%d",
                    time_format = "%H:%M",
                    -- A map for custom variables, the key should be the variable and the value a function.
                    -- Functions are called with obsidian.TemplateContext objects as their sole parameter.
                    -- See: https://github.com/obsidian-nvim/obsidian.nvim/wiki/Template#substitutions
                    -- substitutions = {},

                    -- A map for configuring unique directories and paths for specific templates
                    --- See: https://github.com/obsidian-nvim/obsidian.nvim/wiki/Template#customizations
                    -- customizations = {},
                },
                daily_notes = {
                    -- Optional, if you keep daily notes in a separate directory.
                    folder = "daily",
                    -- Optional, if you want to change the date format for the ID of daily notes.
                    date_format = "DD.MM.YYYY",
                    -- Optional, if you want to change the date format of the default alias of daily notes.
                    -- alias_format = "%-d %B, %Y",
                    -- Optional, default tags to add to each new daily note created.
                    default_tags = { "daily" },
                    -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
                    -- template = "daily.md",
                    -- Optional, if you want `Obsidian yesterday` to return the last work day or `Obsidian tomorrow` to return the next work day.
                    -- workdays_only = true,
                },
            })
        end,
    },
}
