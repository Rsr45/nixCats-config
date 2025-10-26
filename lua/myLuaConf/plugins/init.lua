local colorschemeName = nixCats("colorscheme")
if not require("nixCatsUtils").isNixCats then
    colorschemeName = "onedark"
end

vim.cmd.colorscheme(colorschemeName)

-- NOTE: you can check if you included the category with the thing wherever you want.
if nixCats("general.extra") then
    -- I didnt want to bother with lazy loading this.
    -- I could put it in opt and put it in a spec anyway
    -- and then not set any handlers and it would load at startup,
    -- but why... I guess I could make it load
    -- after the other lze definitions in the next call using priority value?
    -- didnt seem necessary.
    -- Declare a global function to retrieve the current directory
    function _G.get_oil_winbar()
        local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
        local dir = require("oil").get_current_dir(bufnr)
        if dir then
            return vim.fn.fnamemodify(dir, ":~")
        else
            -- If there is no current directory (e.g. over ssh), just show the buffer name
            return vim.api.nvim_buf_get_name(0)
        end
    end

    local detail = false

    vim.g.loaded_netrwPlugin = 1
    vim.opt.splitright = true
    require("oil").setup({
        default_file_explorer = true,
        view_options = {
            show_hidden = true,
        },
        win_options = {
            winbar = "%!v:lua.get_oil_winbar()",
        },
        columns = {
            -- "permissions",
            -- "size",
            -- "mtime",
            "icon",
        },
        keymaps = {
            ["gd"] = {
                desc = "Toggle file detail view",
                callback = function()
                    detail = not detail
                    if detail then
                        require("oil").set_columns({ "permissions", "size", "mtime" })
                    else
                        require("oil").set_columns({ "icon" })
                    end
                end,
            },
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
    vim.keymap.set("n", "<leader>o/", "<cmd>Oil<CR>", { noremap = true, desc = "Open Directory in oil" })
    vim.keymap.set("n", "<leader>-", "<cmd>Oil .<CR>", { noremap = true, desc = "Open nvim root directory" })
end

require("lze").load({
    { import = "myLuaConf.plugins.mini" },
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
    { import = "myLuaConf.plugins.lualine" },
    -- { import = "myLuaConf.plugins.mini-statusline" },
    { import = "myLuaConf.plugins.snacks" },
    -- { import = "myLuaConf.plugins.neorg" },
    { import = "myLuaConf.plugins.obsidian" },
    { import = "myLuaConf.plugins.org" },
    { import = "myLuaConf.plugins.fzf" },
    { import = "myLuaConf.plugins.gitsigns" },
    { import = "myLuaConf.plugins.neogit" },
    {
        "mini.icons",
        for_cat = "general.extra",
        after = function()
            require("mini.icons").setup()
            MiniIcons.mock_nvim_web_devicons()
        end,
    },
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
            { "<leader>mp", "<cmd>MarkdownPreview <CR>",       mode = { "n" }, noremap = true, desc = "markdown preview", },
            { "<leader>ms", "<cmd>MarkdownPreviewStop <CR>",   mode = { "n" }, noremap = true, desc = "markdown preview stop", },
            { "<leader>mt", "<cmd>MarkdownPreviewToggle <CR>", mode = { "n" }, noremap = true, desc = "markdown preview toggle", },
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
            require("render-markdown").setup({})
        end,
    },
    {
        "nvim-highlight-colors",
        for_cat = "general.always",
        lazy = false,
        -- ft = { "" },
        after = function()
            require("nvim-highlight-colors").setup({
                render = "virtual",
                virtual_symbol = "■",
                virtual_symbol_position = "inline",
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
            vim.o.foldcolumn = "1" -- '0' is not bad
            vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true

            -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
            vim.keymap.set("n", "zR", require("ufo").openAllFolds)
            vim.keymap.set("n", "zM", require("ufo").closeAllFolds)

            require("ufo").setup({
                provide_selector = function(bufnr, filetype, buftype)
                    return { "lsp", "treesitter", "indent" }
                end,
            })
        end,
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
                indent = { char = "▏" },
                scope = { enabled = true },
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
        "hlargs",
        for_cat = 'general.extra',
        event = "DeferredUIEnter",
        -- keys = "",
        dep_of = { "nvim-lspconfig" },
        after = function()
            require('hlargs').setup {
                -- color = '#32a88f',
            }
            vim.cmd([[hi clear @lsp.type.parameter]])
            vim.cmd([[hi link @lsp.type.parameter Hlargs]])
        end,
    },
    -- {
    --     "nvim-navic",
    --     for_cat = "general.always",
    --     event = "DeferredUIEnter",
    --     after = function()
    --         require("nvim-navic").setup({
    --             lsp = {
    --                 auto_attach = true,
    --             }
    --         })
    --         vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
    --     end
    -- },
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
                win = {
                    border = "single",
                },
            })
            require("which-key").add({
                { "<leader>t",  group = "toggle" },
                { "<leader>t_", hidden = true },
                { "<leader>s",  group = "search" },
                { "<leader>s_", hidden = true },
                -- { "<leader>o",  group = "open" },
                -- { "<leader>o_", hidden = true },
                -- { "<leader>n",  group = "notes" },
                -- { "<leader>n_", hidden = true },
                { "<leader>f",  group = "file" },
                { "<leader>f_", hidden = true },
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
})
