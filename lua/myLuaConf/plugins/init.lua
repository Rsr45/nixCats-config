local colorschemeName = nixCats("colorscheme")
if not require("nixCatsUtils").isNixCats then
    colorschemeName = "onedark"
end
-- Could I lazy load on colorscheme with lze?
-- sure. But I was going to call vim.cmd.colorscheme() during startup anyway
-- this is just an example, feel free to do a better job!
vim.cmd.colorscheme(colorschemeName)

local ok, notify = pcall(require, "notify")
if ok then
    notify.setup({
        on_open = function(win)
            vim.api.nvim_win_set_config(win, { focusable = false })
        end,
    })
    vim.notify = notify
    vim.keymap.set("n", "<Esc>", function()
        notify.dismiss({ silent = true })
    end, { desc = "dismiss notify popup and clear hlsearch" })
end

-- NOTE: you can check if you included the category with the thing wherever you want.
if nixCats("general.extra") then
    -- I didnt want to bother with lazy loading this.
    -- I could put it in opt and put it in a spec anyway
    -- and then not set any handlers and it would load at startup,
    -- but why... I guess I could make it load
    -- after the other lze definitions in the next call using priority value?
    -- didnt seem necessary.
    vim.g.loaded_netrwPlugin = 1
    require("oil").setup({
        default_file_explorer = true,
        view_options = {
            show_hidden = true,
        },
        columns = {
            "icon",
            "permissions",
            "size",
            -- "mtime",
        },
        keymaps = {
            ["g?"] = "actions.show_help",
            ["<CR>"] = "actions.select",
            ["<C-s>"] = "actions.select_vsplit",
            ["<C-h>"] = "actions.select_split",
            ["<C-t>"] = "actions.select_tab",
            ["<C-p>"] = "actions.preview",
            ["<C-c>"] = "actions.close",
            ["<C-l>"] = "actions.refresh",
            ["-"] = "actions.parent",
            ["_"] = "actions.open_cwd",
            ["`"] = "actions.cd",
            ["~"] = "actions.tcd",
            ["gs"] = "actions.change_sort",
            ["gx"] = "actions.open_external",
            ["g."] = "actions.toggle_hidden",
            ["g\\"] = "actions.toggle_trash",
        },
    })
    vim.keymap.set("n", "-", "<cmd>Oil<CR>", { noremap = true, desc = "Open Parent Directory" })
    vim.keymap.set("n", "<leader>-", "<cmd>Oil .<CR>", { noremap = true, desc = "Open nvim root directory" })
end

require("lze").load({
    { import = "myLuaConf.plugins.telescope" },
    { import = "myLuaConf.plugins.treesitter" },
    { import = "myLuaConf.plugins.completion" },
    { import = "myLuaConf.plugins.navigation" },
    {
        "markdown-preview.nvim",
        -- NOTE: for_cat is a custom handler that just sets enabled value for us,
        -- based on result of nixCats('cat.name') and allows us to set a different default if we wish
        -- it is defined in luaUtils template in lua/nixCatsUtils/lzUtils.lua
        -- you could replace this with enabled = nixCats('cat.name') == true
        -- if you didnt care to set a different default for when not using nix than the default you already set
        for_cat = "general.markdown",
        cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
        ft = "markdown",
        keys = {
            {
                "<leader>mp",
                "<cmd>MarkdownPreview <CR>",
                mode = { "n" },
                noremap = true,
                desc = "markdown preview",
            },
            {
                "<leader>ms",
                "<cmd>MarkdownPreviewStop <CR>",
                mode = { "n" },
                noremap = true,
                desc = "markdown preview stop",
            },
            {
                "<leader>mt",
                "<cmd>MarkdownPreviewToggle <CR>",
                mode = { "n" },
                noremap = true,
                desc = "markdown preview toggle",
            },
        },
        before = function(plugin)
            vim.g.mkdp_auto_close = 0
        end,
    },
    -- {
    --         "render-markdown.nvim",
    --         for_cat = "general.markdown",
    --         ft = "markdown",
    --         cmd = "RenderMarkdown",
    --         after = function()
    --                 require("render-markdown").setup {}
    --         end,
    -- },
    {
        "obsidian.nvim",
        ft = "markdown",
        for_cat = "general.notes",
        -- cmd = { "ObsidianOpen", "ObsidianNew", "Obsidian" },
        after = function()
            require("obsidian").setup({
                -- ui = { enable = false },
                workspaces = {
                    {
                        name = "Personal",
                        path = "~/Personal/Vaults/Personal",
                        overrides = {
                            notes_subdir = "05_Fleeting",
                            attachments = {
                                img_folder = "99_Meta/01_Assets/imgs",
                            },
                        },
                    },
                    {
                        name = "Work",
                        path = "~/Personal/Vaults/Dev",
                        -- overrides = {
                        --         notes_subdir = "",
                        -- },
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
                    folder = "06_Daily",
                    -- Optional, if you want to change the date format for the ID of daily notes.
                    date_format = "%Y-%m-%d",
                    -- Optional, if you want to change the date format of the default alias of daily notes.
                    alias_format = "%B %-d, %Y",
                    -- Optional, default tags to add to each new daily note created.
                    default_tags = { "daily-notes" },
                    -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
                    -- template = "daily.md",
                    -- Optional, if you want `Obsidian yesterday` to return the last work day or `Obsidian tomorrow` to return the next work day.
                    workdays_only = true,
                },
                completion = {
                    -- Enables completion using blink.cmp
                    blink = true,
                    -- Trigger completion at 2 chars.
                    min_chars = 2,
                    -- Set to false to disable new note creation in the picker
                    create_new = true,
                },
            })
        end,
    },
    {
        "nvim-ufo",
        for_cat = "general.always",
        event = "DeferredUIEnter",
        after = function()
            vim.o.foldcolumn = '1' -- '0' is not bad
            vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true

            -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
            vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
            vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

            require("ufo").setup({
                provide_selector = function(bufnr, filetype, buftype)
                    return { "lsp", "treesitter", "indent" }
                end
            })
        end
    },
    {
        "promise-async",
        for_cat = "general.always",
        dep_of = "nvim-ufo",
        -- after = function ()
        -- end
    },
    {
        "undotree",
        for_cat = "general.extra",
        cmd = { "UndotreeToggle", "UndotreeHide", "UndotreeShow", "UndotreeFocus", "UndotreePersistUndo" },
        keys = { { "<leader>U", "<cmd>UndotreeToggle<CR>", mode = { "n" }, desc = "Undo Tree" } },
        before = function(_)
            vim.g.undotree_WindowLayout = 1
            vim.g.undotree_SplitWidth = 40
        end,
    },
    {
        "comment.nvim",
        for_cat = "general.extra",
        event = "DeferredUIEnter",
        after = function(plugin)
            require("Comment").setup()
        end,
    },
    {
        "indent-blankline.nvim",
        for_cat = "general.extra",
        event = "DeferredUIEnter",
        after = function(plugin)
            require("ibl").setup()
        end,
    },
    {
        "mini.surround",
        for_cat = "general.always",
        event = "DeferredUIEnter",
        after = function(plugin)
            require("mini.surround").setup({
                mappings = {
                    add = "gza",            -- Add surrounding in Normal and Visual modes
                    delete = "gzd",         -- Delete surrounding
                    find = "gzf",           -- Find surrounding (to the right)
                    find_left = "gzF",      -- Find surrounding (to the left)
                    highlight = "gzh",      -- Highlight surrounding
                    replace = "gzr",        -- Replace surrounding
                    update_n_lines = "gzn", -- Update `n_lines`
                },
                keys = {
                    { "gz", "", desc = "+surround" },
                },
            })
        end,
    },
    {
        "mini.pairs",
        for_cat = "general.always",
        after = function(plugin)
            require("mini.pairs").setup()
        end,
    },
    {
        "mini.icons",
        for_cat = "general.extra",
        after = function(plugin)
            require("mini.icons").setup()
            MiniIcons.mock_nvim_web_devicons()
        end,
    },
    {
        "vim-startuptime",
        for_cat = "general.extra",
        cmd = { "StartupTime" },
        before = function(_)
            vim.g.startuptime_event_width = 0
            vim.g.startuptime_tries = 10
            vim.g.startuptime_exe_path = nixCats.packageBinPath
        end,
    },
    {
        "fidget.nvim",
        for_cat = "general.extra",
        event = "DeferredUIEnter",
        -- keys = "",
        after = function(plugin)
            require("fidget").setup({})
        end,
    },
    -- {
    --   "hlargs",
    --   for_cat = 'general.extra',
    --   event = "DeferredUIEnter",
    --   -- keys = "",
    --   dep_of = { "nvim-lspconfig" },
    --   after = function(plugin)
    --     require('hlargs').setup {
    --       color = '#32a88f',
    --     }
    --     vim.cmd([[hi clear @lsp.type.parameter]])
    --     vim.cmd([[hi link @lsp.type.parameter Hlargs]])
    --   end,
    -- },
    {
        "nvim-navic",
        for_cat = "general.always",
        event = "DeferredUIEnter",
        dep_of = "breadcrumbs",
        after = function()
            require("nvim-navic").setup({
                lsp = {
                    auto_attach = true,
                }
            })
        end
    },
    {
        "breadcrumbs",
        for_cat = "general.always",
        event = "DeferredUIEnter",
        after = function()
            require("breadcrumbs").setup()
        end
    },
    {
        "lualine.nvim",
        for_cat = "general.always",
        -- cmd = { "" },
        event = "DeferredUIEnter",
        -- ft = "",
        -- keys = "",
        -- colorscheme = "",
        after = function(plugin)
            require("lualine").setup({
                options = {
                    icons_enabled = false,
                    theme = "auto",
                    -- theme = colorschemeName,
                    component_separators = "",
                    section_separators = "",
                    color = { fg = '#c1c1c1', bg = '#121212', gui = '' }, -- maybe probably
                },
                sections = {
                    lualine_a = {
                        {
                            'mode',
                            fmt = function(str) return str:sub(1, 3) end,
                            color = { fg = '#c1c1c1', bg = '#121212', gui = '' },
                        }
                    },
                    lualine_b = {
                        {
                            "lsp_status",
                            color = { fg = '#c1c1c1', bg = '#121212', gui = '' },
                        }
                    },
                    lualine_c = {
                        {
                            'filename',
                            file_status = true,     -- Displays file status (readonly status, modified status)
                            newfile_status = false, -- Display new file status (new file means no write after created)
                            path = 1,               -- 0: Just the filename
                            -- 1: Relative path
                            -- 2: Absolute path
                            -- 3: Absolute path, with tilde as the home directory
                            -- 4: Filename and parent dir, with tilde as the home directory

                            shorting_target = 40, -- Shortens path to leave 40 spaces in the window
                            -- for other components. (terrible name, any suggestions?)
                            symbols = {
                                modified = '[+]',      -- Text to show when the file is modified.
                                readonly = '[-]',      -- Text to show when the file is non-modifiable or readonly.
                                unnamed = '[No Name]', -- Text to show for unnamed buffers.
                                newfile = '[New]',     -- Text to show for newly created file before first write
                            },
                            color = { fg = '#c1c1c1', bg = '#121212', gui = '' },
                        },
                    },
                    lualine_x = {
                        {
                            color = { fg = '#c1c1c1', bg = '#121212', gui = '' },
                        }
                    },
                    lualine_y = {
                        {
                            color = { fg = '#c1c1c1', bg = '#121212', gui = '' },
                        }
                    },
                    lualine_z = {
                        {
                            "location",
                            color = { fg = '#c1c1c1', bg = '#121212', gui = '' },
                        }
                    }
                },
                -- tabline = {
                --         lualine_a = { 'buffers' },
                --         -- if you use lualine-lsp-progress, I have mine here instead of fidget
                --         -- lualine_b = { 'lsp_progress', },
                --         lualine_z = { 'tabs' }
                -- },
            })
        end,
    },
    {
        "gitsigns.nvim",
        for_cat = "general.always",
        event = "DeferredUIEnter",
        -- cmd = { "" },
        -- ft = "",
        -- keys = "",
        -- colorscheme = "",
        after = function(plugin)
            require("gitsigns").setup({
                -- See `:help gitsigns.txt`
                signs = {
                    add = { text = '+' },
                    change = { text = '~' },
                    delete = { text = '_' },
                    topdelete = { text = '‾' },
                    changedelete = { text = '~' },
                },
                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns

                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Navigation
                    map({ "n", "v" }, "]c", function()
                        if vim.wo.diff then
                            return "]c"
                        end
                        vim.schedule(function()
                            gs.next_hunk()
                        end)
                        return "<Ignore>"
                    end, { expr = true, desc = "Jump to next hunk" })

                    map({ "n", "v" }, "[c", function()
                        if vim.wo.diff then
                            return "[c"
                        end
                        vim.schedule(function()
                            gs.prev_hunk()
                        end)
                        return "<Ignore>"
                    end, { expr = true, desc = "Jump to previous hunk" })

                    -- Actions
                    -- visual mode
                    map("v", "<leader>hs", function()
                        gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
                    end, { desc = "stage git hunk" })
                    map("v", "<leader>hr", function()
                        gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
                    end, { desc = "reset git hunk" })
                    -- normal mode
                    map("n", "<leader>gs", gs.stage_hunk, { desc = "git stage hunk" })
                    map("n", "<leader>gr", gs.reset_hunk, { desc = "git reset hunk" })
                    map("n", "<leader>gS", gs.stage_buffer, { desc = "git Stage buffer" })
                    map("n", "<leader>gu", gs.undo_stage_hunk, { desc = "undo stage hunk" })
                    map("n", "<leader>gR", gs.reset_buffer, { desc = "git Reset buffer" })
                    map("n", "<leader>gp", gs.preview_hunk, { desc = "preview git hunk" })
                    map("n", "<leader>gb", function()
                        gs.blame_line({ full = false })
                    end, { desc = "git blame line" })
                    map("n", "<leader>gd", gs.diffthis, { desc = "git diff against index" })
                    map("n", "<leader>gD", function()
                        gs.diffthis("~")
                    end, { desc = "git diff against last commit" })

                    -- Toggles
                    map("n", "<leader>gtb", gs.toggle_current_line_blame,
                        { desc = "toggle git blame line" })
                    map("n", "<leader>gtd", gs.toggle_deleted, { desc = "toggle git show deleted" })

                    -- Text object
                    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>",
                        { desc = "select git hunk" })
                end,
            })
            -- vim.cmd([[hi GitSignsAdd guifg=#04de21]])
            -- vim.cmd([[hi GitSignsChange guifg=#83fce6]])
            -- vim.cmd([[hi GitSignsDelete guifg=#fa2525]])
        end,
    },
    {
        "which-key.nvim",
        for_cat = "general.extra",
        -- cmd = { "" },
        event = "DeferredUIEnter",
        -- ft = "",
        -- keys = "",
        -- colorscheme = "",
        after = function(plugin)
            require("which-key").setup({
                preset = "helix",
            })
            require("which-key").add({
                { "<leader><leader>",  group = "buffer commands" },
                { "<leader><leader>_", hidden = true },
                { "<leader>l",         group = "Lsp" },
                { "<leader>l_",        hidden = true },
                { "<leader>d",         group = "[d]ocument" },
                { "<leader>d_",        hidden = true },
                { "<leader>g",         group = "[g]it" },
                { "<leader>g_",        hidden = true },
                { "<leader>m",         group = "[m]arkdown" },
                { "<leader>m_",        hidden = true },
                { "<leader>r",         group = "[r]ename" },
                { "<leader>r_",        hidden = true },
                { "<leader>f",         group = "Telescope" },
                { "<leader>f_",        hidden = true },
                { "<leader>t",         group = "[t]oggles" },
                { "<leader>t_",        hidden = true },
                { "<leader>w",         group = "[w]orkspace" },
                { "<leader>w_",        hidden = true },
            })
        end,
    },
})
