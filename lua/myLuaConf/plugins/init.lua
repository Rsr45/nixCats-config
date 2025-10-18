local colorschemeName = nixCats("colorscheme")
if not require("nixCatsUtils").isNixCats then
    colorschemeName = "onedark"
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
    { import = "myLuaConf.plugins.noice" },
    { import = "myLuaConf.plugins.telescope" },
    { import = "myLuaConf.plugins.treesitter" },
    { import = "myLuaConf.plugins.completion" },
    { import = "myLuaConf.plugins.navigation" },
    { import = "myLuaConf.plugins.mini" },
    { import = "myLuaConf.plugins.lualine" },
    { import = "myLuaConf.plugins.snacks" },
    -- { import = "myLuaConf.plugins.neorg" },
    { import = "myLuaConf.plugins.obsidian" },
    { import = "myLuaConf.plugins.org" },
    { import = "myLuaConf.plugins.fzf" },
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
    -- {
    --     "fidget.nvim",
    --     for_cat = "general.extra",
    --     event = "DeferredUIEnter",
    --     -- keys = "",
    --     after = function()
    --         require("fidget").setup({
    --             notification = {
    --                 window = {
    --                     border = "single",
    --                     x_padding = 1,
    --                     y_padding = 1,
    --                 },
    --             },
    --         })
    --     end,
    -- },
    -- {
    --     "nvim-navic",
    --     for_cat = "general.always",
    --     event = "DeferredUIEnter",
    --     dep_of = { "breadcrumbs", "nvim-navbuddy" },
    --     after = function()
    --         require("nvim-navic").setup({
    --             lsp = {
    --                 auto_attach = true,
    --             }
    --         })
    --         vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
    --     end
    -- },
    -- {
    --     "nvim-navbuddy",
    --     for_cat = "general.always",
    --     cmd = "Navbuddy",
    --     -- keys = {
    --     --     {},
    --     -- },
    --     after = function()
    --         require("nvim-navbuddy").setup({
    --             lsp = {
    --                 auto_attach = true,
    --             },
    --         })
    --     end
    -- },
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
