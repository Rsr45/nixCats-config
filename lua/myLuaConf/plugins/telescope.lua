-- Telescope is a fuzzy finder that comes with a lot of different things that
-- it can fuzzy find! It's more than just a "file finder", it can search
-- many different aspects of Neovim, your workspace, LSP, and more!
--
-- The easiest way to use telescope, is to start by doing something like:
--  :Telescope help_tags
--
-- After running this command, a window will open up and you're able to
-- type in the prompt window. You'll see a list of help_tags options and
-- a corresponding preview of the help.
--
-- Two important keymaps to use while in telescope are:
--  - Insert mode: <c-/>
--  - Normal mode: ?
--
-- This opens a window that shows you all of the keymaps for the current
-- telescope picker. This is really useful to discover what Telescope can
-- do as well as how to actually do it!

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`

-- Telescope live_grep in git root
-- Function to find the git root directory based on the current buffer's path
local function find_git_root()
    -- Use the current buffer's path as the starting point for the git search
    local current_file = vim.api.nvim_buf_get_name(0)
    local current_dir
    local cwd = vim.fn.getcwd()
    -- If the buffer is not associated with a file, return nil
    if current_file == "" then
        current_dir = cwd
    else
        -- Extract the directory from the current file's path
        current_dir = vim.fn.fnamemodify(current_file, ":h")
    end

    -- Find the Git root directory from the current file's path
    local git_root = vim.fn.systemlist("git -C " .. vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel")[1]
    if vim.v.shell_error ~= 0 then
        print("Not a git repository. Searching on current working directory")
        return cwd
    end
    return git_root
end

-- Custom live_grep function to search in git root
local function live_grep_git_root()
    local git_root = find_git_root()
    if git_root then
        require('telescope.builtin').live_grep({
            search_dirs = { git_root },
        })
    end
end

return {
    {
        "telescope.nvim",
        for_cat = 'general.telescope',
        cmd = { "Telescope", "LiveGrepGitRoot" },
        -- NOTE: our on attach function defines keybinds that call telescope.
        -- so, the on_require handler will load telescope when we use those.
        on_require = { "telescope", },
        -- event = "",
        -- ft = "",
        keys = {
            -- { "<leader>fM", '<cmd>Telescope notify<CR>', mode = {"n"}, desc = 'List Notifications', },
            -- { "<leader>fp",live_grep_git_root, mode = {"n"}, desc = 'Grep Git Root', },
            -- { "<leader>/", function()
            --   -- Slightly advanced example of overriding default behavior and theme
            --   -- You can pass additional configuration to telescope to change theme, layout, etc.
            --   require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
            --     winblend = 10,
            --     previewer = false,
            --   })
            -- end, mode = {"n"}, desc = 'Search in Current Buffer', },
            -- { "<leader>f/", function()
            --   require('telescope.builtin').live_grep {
            --     grep_open_files = true,
            --     prompt_title = 'Grep Buffers',
            --   }
            -- end, mode = {"n"}, desc = 'Grep in Open Files' },
            -- { "<leader>fb", function() return require('telescope.builtin').buffers() end, mode = {"n"}, desc = 'List Buffers', },
            -- { "<leader>f.", function() return require('telescope.builtin').oldfiles() end, mode = {"n"}, desc = 'List Recent Files', },
            -- { "<leader>fr", function() return require('telescope.builtin').resume() end, mode = {"n"}, desc = 'Resume Last Action', },
            -- { "<leader>fd", function() return require('telescope.builtin').diagnostics() end, mode = {"n"}, desc = 'Diagnostics', },
            -- { "<leader>fg", function() return require('telescope.builtin').live_grep() end, mode = {"n"}, desc = 'Grep in Files', },
            -- { "<leader>fw", function() return require('telescope.builtin').grep_string() end, mode = {"n"}, desc = 'Grep Word Under Cursor', },
            -- { "<leader>fs", function() return require('telescope.builtin').builtin() end, mode = {"n"}, desc = 'List Telescope Actions', },
            -- { "<leader>ff", function() return require('telescope.builtin').find_files() end, mode = {"n"}, desc = 'List Files', },
            -- { "<leader>fh", function() return require('telescope.builtin').help_tags() end, mode = {"n"}, desc = 'Help', },
        },
        -- colorscheme = "",
        load = function(name)
            vim.cmd.packadd(name)
            vim.cmd.packadd("telescope-fzf-native.nvim")
            vim.cmd.packadd("telescope-ui-select.nvim")
        end,
        after = function(plugin)
            require('telescope').setup {
                -- You can put your default mappings / updates / etc. in here
                --  All the info you're looking for is in `:help telescope.setup()`
                --
                defaults = {
                    mappings = {
                        i = { ['<c-enter>'] = 'to_fuzzy_refine' },
                    },
                },
                -- pickers = {}
                extensions = {
                    ['ui-select'] = {
                        require('telescope.themes').get_dropdown(),
                    },
                },
            }

            -- Enable telescope extensions, if they are installed
            pcall(require('telescope').load_extension, 'fzf')
            pcall(require('telescope').load_extension, 'ui-select')

            vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})
        end,
    },
}
