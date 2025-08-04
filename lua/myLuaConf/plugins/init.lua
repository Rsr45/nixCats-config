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
    {
        "nui.nvim",
        for_cat = "general.always",
        lazy = false,
        dep_of = { "noice.nvim" },
    },
    {
        "noice.nvim",
        for_cat = "general.always",
        lazy = false,
        after = function()
            require("noice").setup({
                lsp = {
                    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
                    },
                },
                -- you can enable a preset for easier configuration
                presets = {
                    bottom_search = true,         -- use a classic bottom cmdline for search
                    command_palette = true,       -- position the cmdline and popupmenu together
                    long_message_to_split = true, -- long messages will be sent to a split
                    inc_rename = false,           -- enables an input dialog for inc-rename.nvim
                    lsp_doc_border = false,       -- add a border to hover docs and signature help
                },
            })
        end,
    },
    -- { import = "myLuaConf.plugins.telescope" },
    { import = "myLuaConf.plugins.treesitter" },
    { import = "myLuaConf.plugins.completion" },
    { import = "myLuaConf.plugins.navigation" },
    { import = "myLuaConf.plugins.mini" },
    { import = "myLuaConf.plugins.lualine" },
    {
        "snacks.nvim",
        for_cat = "general.always",
        lazy = false,
        keys = {
            { "<leader>u",  "<cmd>lua Snacks.picker.undo()<CR>",                                  mode = { "n" }, desc = "Undo" },
            { "<leader>f",  "<cmd>lua Snacks.picker.files()<CR>",                                 mode = { "n" }, desc = "Files" },
            { "<leader>F",  "<cmd>lua Snacks.picker.files({ cwd = vim.fn.expand('%:p:h') })<CR>", mode = { "n" }, desc = "Files in cwd" },
            { "<leader>b",  "<cmd>lua Snacks.picker.buffers()<CR>",                               mode = { "n" }, desc = "Buffer" },
            { "<leader>g",  "<cmd>lua Snacks.picker.grep()<CR>",                                  mode = { "n" }, desc = "Grep" },
            { "<leader>G",  "<cmd>lua Snacks.picker.grep_word()<CR>",                             mode = { "n" }, desc = "Grep Word Under Cursor" },
            { "<leader>s",  "<cmd>lua Snacks.picker.lsp_symbols()<CR>",                           mode = { "n" }, desc = "Document Symbols" },
            { "<leader>ws", "<cmd>lua Snacks.picker.lsp_symbols()<CR>",                           mode = { "n" }, desc = "[D]ocument [S]ymbols" },
            { "<leader>S",  "<cmd>lua Snacks.picker.lsp_workspace_symbols()<CR>",                 mode = { "n" }, desc = "Workspace Symbols" },
            { "<leader>wS", "<cmd>lua Snacks.picker.lsp_workspace_symbols()<CR>",                 mode = { "n" }, desc = "[W]orkspace [S]ymbols" },
            { "<leader>d",  "<cmd>lua Snacks.picker.diagnostics()<CR>",                           mode = { "n" }, desc = "Diagnostics" },
            { "<leader>D",  "<cmd>lua Snacks.picker.diagnostics_buffers()<CR>",                   mode = { "n" }, desc = "Diagnostics Buffers" },
            -- { "<leader>gr", "<cmd>lua Snacks.picker.lsp_references()<CR>",                        mode = { "n" }, desc = "[G]oto [R]eferences" },
            -- { "<leader>gI", "<cmd>lua Snacks.picker.lsp_implementations()<CR>",                   mode = { "n" }, desc = "[G]oto [I]mplementation" },
            { "<leader>t",  "<cmd>lua Snacks.explorer()<CR>",                                     mode = { "n" }, desc = "Explorer" },
        },
        after = function()
            require("snacks").setup({
                statuscolumn = {
                    -- your statuscolumn configuration comes here
                    -- or leave it empty to use the default settings
                    -- refer to the configuration section below
                    left = { "mark", "sign" }, -- priority of signs on the left (high to low)
                    right = { "fold", "git" }, -- priority of signs on the right (high to low)
                    folds = {
                        open = false,          -- show open fold icons
                        git_hl = false,        -- use Git Signs hl for fold icons
                    },
                    git = {
                        -- patterns to match Git signs
                        patterns = { "GitSign", "MiniDiffSign" },
                    },
                    refresh = 50, -- refresh at most every 50ms
                },
                picker = {
                    sources = {
                    },
                },
            })
        end,
    },
    -- {
    -- try to replicate its ui in snacks.picker if possible if not its no big deal
    --     "fzf-lua",
    --     for_cat = "general.always",
    --     lazy = false,
    -- },
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
        before = function()
            vim.g.mkdp_auto_close = 0
        end,
    },
    {
        "render-markdown.nvim",
        for_cat = "general.markdown",
        ft = "markdown",
        cmd = "RenderMarkdown",
        after = function()
            require("render-markdown").setup {}
        end,
    },
    {
        "obsidian.nvim",
        -- ft = "markdown",
        for_cat = "general.notes",
        cmd = { "ObsidianOpen", "ObsidianNew", "ObsidianSearch" },
        after = function()
            require("obsidian").setup({
                ui = { enable = false },
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
        "nvim-highlight-colors",
        for_cat = "general.always",
        lazy = false,
        -- ft = { "" },
        after = function()
            require('nvim-highlight-colors').setup({
                render = 'virtual',
                virtual_symbol = '■',
                virtual_symbol_position = 'inline',
            })
        end,
    },
    -- {
    --     "vim-sleuth",
    --     for_cat = "general.always",
    --     lazy = false,
    -- },
    -- {
    --     "vim-visual-multi",
    --     for_cat = "general.always",
    --     lazy = false,
    -- },
    {
        "vim-fugitive",
        for_cat = "general.always",
        cmd = { "G", "Git" },
    },
    {
        "nvim-ufo",
        for_cat = "general.always",
        lazy = false,
        -- event = "DeferredUIEnter",
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
        "indent-blankline.nvim",
        for_cat = "general.extra",
        event = "DeferredUIEnter",
        after = function()
            require("ibl").setup({
                indent = { char = "▏", },
                scope = { enabled = true, },
            })
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
        after = function()
            require("fidget").setup({
                notification = {
                    window = {
                        border = "single",
                        x_padding = 1,
                        y_padding = 1,
                    },
                },
            })
        end,
    },
    {
        "nvim-navic",
        for_cat = "general.always",
        event = "DeferredUIEnter",
        dep_of = { "breadcrumbs", "nvim-navbuddy" },
        after = function()
            require("nvim-navic").setup({
                lsp = {
                    auto_attach = true,
                }
            })
            -- vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
        end
    },
    {
        "nvim-navbuddy",
        for_cat = "general.always",
        cmd = "Navbuddy",
        -- keys = {
        --     {},
        -- },
        after = function()
            require("nvim-navbuddy").setup({
                lsp = {
                    auto_attach = true,
                },
            })
        end
    },
    -- {
    --     "bufferline.nvim",
    --     for_cat = "general.always",
    --     event = "DeferredUIEnter",
    --     after = function()
    --         require("bufferline").setup({
    --
    --         })
    --     end
    -- },
    {
        "gitsigns.nvim",
        for_cat = "general.always",
        event = "DeferredUIEnter",
        -- cmd = { "" },
        -- ft = "",
        -- keys = "",
        -- colorscheme = "",
        after = function()
            require("gitsigns").setup({
                -- See `:help gitsigns.txt`
                -- signs = {
                --     add = { text = '+' },
                --     change = { text = '~' },
                --     delete = { text = '_' },
                --     topdelete = { text = '‾' },
                --     changedelete = { text = '~' },
                -- },
                -- on_attach = function(bufnr)
                --     local gs = package.loaded.gitsigns
                --
                --     local function map(mode, l, r, opts)
                --         opts = opts or {}
                --         opts.buffer = bufnr
                --         vim.keymap.set(mode, l, r, opts)
                --     end
                --
                --     -- Navigation
                --     map({ "n", "v" }, "]c", function()
                --         if vim.wo.diff then
                --             return "]c"
                --         end
                --         vim.schedule(function()
                --             gs.next_hunk()
                --         end)
                --         return "<Ignore>"
                --     end, { expr = true, desc = "Jump to next hunk" })
                --
                --     map({ "n", "v" }, "[c", function()
                --         if vim.wo.diff then
                --             return "[c"
                --         end
                --         vim.schedule(function()
                --             gs.prev_hunk()
                --         end)
                --         return "<Ignore>"
                --     end, { expr = true, desc = "Jump to previous hunk" })
                --
                --     -- Actions
                --     -- visual mode
                --     map("v", "<leader>hs", function()
                --         gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
                --     end, { desc = "stage git hunk" })
                --     map("v", "<leader>hr", function()
                --         gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
                --     end, { desc = "reset git hunk" })
                --     -- normal mode
                --     map("n", "<leader>gs", gs.stage_hunk, { desc = "git stage hunk" })
                --     map("n", "<leader>grr", gs.reset_hunk, { desc = "git reset hunk" })
                --     map("n", "<leader>gS", gs.stage_buffer, { desc = "git Stage buffer" })
                --     map("n", "<leader>gu", gs.undo_stage_hunk, { desc = "undo stage hunk" })
                --     map("n", "<leader>grR", gs.reset_buffer, { desc = "git Reset buffer" })
                --     map("n", "<leader>gp", gs.preview_hunk, { desc = "preview git hunk" })
                --     map("n", "<leader>gb", function()
                --         gs.blame_line({ full = false })
                --     end, { desc = "git blame line" })
                --     map("n", "<leader>gd", gs.diffthis, { desc = "git diff against index" })
                --     map("n", "<leader>gD", function()
                --         gs.diffthis("~")
                --     end, { desc = "git diff against last commit" })
                --
                --     -- Toggles
                --     map("n", "<leader>gtb", gs.toggle_current_line_blame,
                --         { desc = "toggle git blame line" })
                --     map("n", "<leader>gtd", gs.toggle_deleted, { desc = "toggle git show deleted" })
                --
                --     -- Text object
                --     map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>",
                --         { desc = "select git hunk" })
                -- end,
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
        after = function()
            require("which-key").setup({
                preset = "helix",
            })
            require("which-key").add({
                -- { "<leader><leader>",  group = "buffer commands" },
                -- { "<leader><leader>_", hidden = true },
                { "<leader>c",  group = "[c]ode" },
                { "<leader>c_", hidden = true },
                { "<leader>d",  group = "[d]ocument" },
                { "<leader>d_", hidden = true },
                { "<leader>m",  group = "[m]arkdown" },
                { "<leader>m_", hidden = true },
                { "<leader>r",  group = "[r]ename" },
                { "<leader>r_", hidden = true },
                { "<leader>w",  group = "[w]orkspace" },
                { "<leader>w_", hidden = true },
                { "<leader>l",  group = "[l]sp" },
                { "<leader>l_", hidden = true },
            })
        end,
    },
})
