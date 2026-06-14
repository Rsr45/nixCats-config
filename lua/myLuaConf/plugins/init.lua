-- local colorschemeName = nixCats("colorscheme")
-- if not require("nixCatsUtils").isNixCats then
--     colorschemeName = "onedark"
-- end
--
-- vim.cmd.colorscheme(colorschemeName)
--
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

    -- local detail = false

    local permission_hlgroups = {
        ['-'] = 'NonText',
        ['r'] = 'DiagnosticSignWarn',
        ['w'] = 'DiagnosticSignError',
        ['x'] = 'DiagnosticSignOk',
    }

    vim.g.loaded_netrwPlugin = 1
    vim.opt.splitright = true
    require("oil").setup({
        default_file_explorer = true,
        view_options = {
            show_hidden = true,
        },

        columns = {
            {
                'permissions',
                highlight = function(permission_str)
                    local hls = {}
                    for i = 1, #permission_str do
                        local char = permission_str:sub(i, i)
                        table.insert(hls, { permission_hlgroups[char], i - 1, i })
                    end
                    return hls
                end,
            },
            { 'size',  highlight = 'Special' },
            { 'mtime', highlight = 'Question' },
            {
                'icon',
                -- default_file = icon_file,
                -- directory = icon_dir,
                add_padding = true,
            },
        },
        win_options = {
            number = false,
            relativenumber = false,
            signcolumn = 'no',
            foldcolumn = '0',
            statuscolumn = '',
            winbar = "%!v:lua.get_oil_winbar()",
        },

        keymaps = {
            -- ["gd"] = {
            --     desc = "Toggle file detail view",
            --     callback = function()
            --         detail = not detail
            --         if detail then
            --             require("oil").set_columns({ "permissions", "size", "mtime" })
            --         else
            --             require("oil").set_columns({ "icon" })
            --         end
            --     end,
            -- },
            ["g?"] = "actions.show_help",
            ["<CR>"] = "actions.select",
            ["<C-s>"] = "actions.select_vsplit",
            ["<C-h>"] = "actions.select_split",
            ["<C-t>"] = "actions.select_tab",
            ["<C-p>"] = "actions.preview",
            ["<C-c>"] = "actions.close",
            ["<C-l>"] = "actions.refresh",
            ["-"] = "actions.parent",
            ["<BS>"] = "actions.parent",
            ["_"] = "actions.open_cwd",
            ["`"] = "actions.cd",
            ["~"] = "actions.tcd",
            ["gs"] = "actions.change_sort",
            ["gx"] = "actions.open_external",
            ["g."] = "actions.toggle_hidden",
            ["g\\"] = "actions.toggle_trash",
        },
    })

    -- vim.keymap.set("n", "-", "<cmd>Oil<CR>", {
    --     noremap = true,
    --     desc = "Open Directory in Oil",
    -- })
    -- vim.keymap.set("n", "<leader>-", "<cmd>Oil .<CR>", {
    --     noremap = true,
    --     desc = "Open nvim root directory",
    -- })
    vim.keymap.set("n", "<leader>oe", "<cmd>Oil --float<CR>", {
        noremap = true,
        desc = "Open Directory in Oil",
    })
    -- vim.keymap.set("n", "<leader>tO", "<cmd>Oil .<CR>", {
    --     noremap = true,
    --     desc = "Open Directory in Oil",
    -- })

    vim.cmd([[hi! link WinBar StatusLine]])
    vim.cmd([[hi! link WinBarNC StatusLineNC]])
end

require("lze").load({
    { import = "myLuaConf.plugins.mini" },
    -- { import = "myLuaConf.plugins.mini-clue" },
    {
        "nui.nvim",
        for_cat = "general.always",
        lazy = true,
        dep_of = { "noice.nvim" },
    },
    { import = "myLuaConf.plugins.noice" },
    { import = "myLuaConf.plugins.treesitter" },
    { import = "myLuaConf.plugins.completion" },
    { import = "myLuaConf.plugins.navigation" },
    { import = "myLuaConf.plugins.fold" },
    -- { import = "myLuaConf.plugins.mini-statusline" },
    -- { import = "myLuaConf.plugins.lualine" },
    { import = "myLuaConf.plugins.lualine-grimm" },
    { import = "myLuaConf.plugins.snacks" },
    { import = "myLuaConf.plugins.org" },
    { import = "myLuaConf.plugins.obsidian" },
    { import = "myLuaConf.plugins.neorg" },
    { import = "myLuaConf.plugins.neogit" },
    { import = "myLuaConf.plugins.whichkey" }, -- try mini clue
    -- { import = "myLuaConf.plugins.smartcolumn" }, -- no need for now
    { import = "myLuaConf.plugins.trouble" },
    { import = "myLuaConf.plugins.edgy" },
    { import = "myLuaConf.plugins.img-clip" },
    { import = "myLuaConf.plugins.mini-base16" },
    -- { import = "myLuaConf.plugins.feed" },
    {
        "mini.icons",
        for_cat = "general.extra",
        after = function()
            require("mini.icons").setup()
            MiniIcons.mock_nvim_web_devicons()
        end,
    },
    -- {
    --
    --     "indent-blankline.nvim",
    --     for_cat = "general.extra",
    --     event = "BufReadPost",
    --     after = function()
    --         require("ibl").setup({
    --             indent = { char = "╎¦┆" },
    --             scope = { enabled = true },
    --         })
    --     end,
    -- },
    -- {
    --     "vimtex",
    --     lazy = false,
    --     for_cat = "general.always",
    --     after = function()
    --         vim.g.vimtex_view_method = "sioyek"
    --         vim.g.vimtex_syntax_enabled = 0
    --     end,
    -- },
    {
        "markdown-preview.nvim",
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
            require("render-markdown").setup({
                render_modes = true,
                bullet = {
                    enabled = true,
                    render_modes = false,
                    icons = { "󰫶 ", "󱂉 " },
                    ordered_icons = function(ctx)
                        local value = vim.trim(ctx.value)
                        local index = tonumber(value:sub(1, #value - 1))
                        return ('%d.'):format(index > 1 and index or ctx.index)
                    end,
                    highlight = "RenderMarkdownBullet",
                    scope_highlight = {},
                    scope_priority = nil,
                    indent = 2,
                    left_pad = 2,
                },
                checkbox = {
                    enabled = true,
                    left_pad = 2,
                    indent = 2,
                },
                code = {
                    -- above = " ",
                    -- below = " ",
                    -- border = "thick",
                    -- language_pad = 2,
                    -- left_pad = 4,
                    position = "left",
                    -- right_pad = 6,
                    sign = false,
                    width = "full",
                },
                heading = {
                    border = false,
                    -- icons = {
                    --     -- "▼ ",
                    --     -- "▽ ",
                    --     -- "▼ ",
                    --     -- "▽ ",
                    --     -- "▼ ",
                    --     -- "▽ "
                    -- },
                    icons = function(ctx)
                        return table.concat(ctx.sections, '.') .. ' '
                    end,
                    position = "inline",
                    sign = false,
                    width = "full",
                    left_pad = -2,
                    backgrounds = { "",
                        "",
                        "",
                        "",
                        "",
                        "" },
                },
                -- heading = {
                --     width = "block",
                --     backgrounds = {
                --         "MiniStatusLineModeNormal",
                --         "MiniStatusLineModeInsert",
                --         "MiniStatusLineModeReplace",
                --         "MiniStatusLineModeVisual",
                --         "MiniStatusLineModeCommand",
                --         "MiniStatusLineModeOther",
                --     },
                --     sign = true,
                --     left_pad = 1,
                --     right_pad = 0,
                --     position = "right",
                --     icons = {
                --         "",
                --         "",
                --         "",
                --         "",
                --         "",
                --         "",
                --     },
                -- },
                indent = {
                    enabled = true,
                    skip_heading = false,
                    highlight = "",
                    icon = "  ",
                },
                paragraph = {
                    enabled = true,
                    -- render_modes = false,
                    -- left_margin = 0,
                    indent = 2,
                    -- min_width = 0,
                },
                signs = {
                    enabled = false,
                },
            })
        end,
    },
    {
        "nvim-highlight-colors",
        for_cat = "general.always",
        ft = { "css", "scss" },
        after = function()
            require("nvim-highlight-colors").setup({
                render = "virtual",
                virtual_symbol = "■",
                virtual_symbol_position = "inline",
            })
        end,
    },
    {
        "vim-sleuth",
        for_cat = "general.always",
        lazy = false,
    },
    {
        "vim-fugitive",
        for_cat = "general.always",
        cmd = { "G", "Git" },
        keys = {
            { "<leader>ga", mode = { "n" }, "<cmd>Git add %:p<CR>", desc = "Add" },
        },
    },
    {
        "vim-eunuch",
        for_cat = "general.always",
        cmd = {
            "Rename",
            "Copy",
            "Unlink",
            "Duplicate",
            "Remove",
            "Move",
            "Delete",
            "Chmod",
            "Mkdir",
            "Cfind",
            "Clocate",
            "Lfind",
            "Llocate",
            "SudoEdit",
            "SudoWrite",
            "Wall",
            "W",
        },
        keys = {
            -- { "<leader>fD", mode = { "n" }, "<cmd>Delete<Cr>", desc = "[D]elete File" },
            {
                "<leader>bR",
                mode = { "n" },
                function()
                    local new_name = vim.fn.input("Enter new filename to save as: ")
                    if new_name ~= "" then
                        vim.cmd("Rename " .. new_name)
                    else
                        print("Aborted: No filename entered.")
                    end
                end,
                desc = "[R]ename Buffer",
            },
            {
                "<leader>fR",
                mode = { "n" },
                function()
                    local new_name = vim.fn.input("Enter new filename to save as: ")
                    if new_name ~= "" then
                        vim.cmd("Rename " .. new_name)
                    else
                        print("Aborted: No filename entered.")
                    end
                end,
                desc = "[R]ename File",
            },
            {
                "<leader>fS",
                mode = { "n" },
                function()
                    local new_name = vim.fn.input("Enter new filename to save as: ")
                    if new_name ~= "" then
                        vim.cmd("saveas " .. new_name)
                    else
                        print("Aborted: No filename entered.")
                    end
                end,
                desc = "[S]ave File As",
            },
        },
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
        keys = { { "<leader>u", "<cmd>UndotreeToggle<CR>", mode = { "n" }, desc = "Undo Tree" } },
        before = function(_)
            vim.g.undotree_WindowLayout = 1
            vim.g.undotree_SplitWidth = 40
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
        after = function()
            require("fidget").setup({
                notification = {
                    window = {
                        border = "none",
                        x_padding = 1,
                        y_padding = 1,
                    },
                },
            })
        end,
    },
    -- {
    --     "hlargs",
    --     for_cat = 'general.extra',
    --     event = "DeferredUIEnter",
    --     -- keys = "",
    --     dep_of = { "nvim-lspconfig" },
    --     after = function()
    --         require('hlargs').setup {
    --             -- color = '#32a88f',
    --         }
    --         vim.cmd([[hi clear @lsp.type.parameter]])
    --         vim.cmd([[hi link @lsp.type.parameter Hlargs]])
    --     end,
    -- },
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
})
