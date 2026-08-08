-- local colorschemeName = nixCats("colorscheme")
-- if not require("nixCatsUtils").isNixCats then
--     colorschemeName = "onedark"
-- end
--
-- vim.cmd.colorscheme(colorschemeName)
-- no need for it using stylix with mini-base16

-- if using it on non nix sysemts
if not require("nixCatsUtils").isNixCats then
    vim.cmd.colorscheme("onedark")
end

-- -- NOTE: you can check if you included the category with the thing wherever you want.
-- if nixCats("general.extra") then
--     -- I didnt want to bother with lazy loading this.
--     -- I could put it in opt and put it in a spec anyway
--     -- and then not set any handlers and it would load at startup,
--     -- but why... I guess I could make it load
--     -- after the other lze definitions in the next call using priority value?
--     -- didnt seem necessary.
--     -- Declare a global function to retrieve the current directory
--     function _G.get_oil_winbar()
--         local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
--         local dir = require("oil").get_current_dir(bufnr)
--         if dir then
--             return vim.fn.fnamemodify(dir, ":~")
--         else
--             -- If there is no current directory (e.g. over ssh), just show the buffer name
--             return vim.api.nvim_buf_get_name(0)
--         end
--     end
--
--     -- local detail = false
--
--     local permission_hlgroups = {
--         ['-'] = 'NonText',
--         ['r'] = 'DiagnosticSignWarn',
--         ['w'] = 'DiagnosticSignError',
--         ['x'] = 'DiagnosticSignOk',
--     }
--
--     vim.g.loaded_netrwPlugin = 1
--     vim.opt.splitright = true
--     require("oil").setup({
--         default_file_explorer = true,
--         view_options = {
--             show_hidden = true,
--         },
--
--         columns = {
--             {
--                 'permissions',
--                 highlight = function(permission_str)
--                     local hls = {}
--                     for i = 1, #permission_str do
--                         local char = permission_str:sub(i, i)
--                         table.insert(hls, { permission_hlgroups[char], i - 1, i })
--                     end
--                     return hls
--                 end,
--             },
--             { 'size',  highlight = 'Special' },
--             { 'mtime', highlight = 'Question' },
--             {
--                 'icon',
--                 -- default_file = icon_file,
--                 -- directory = icon_dir,
--                 add_padding = true,
--             },
--         },
--         win_options = {
--             number = false,
--             relativenumber = false,
--             signcolumn = 'no',
--             foldcolumn = '0',
--             statuscolumn = '',
--             winbar = "%!v:lua.get_oil_winbar()",
--         },
--
--         keymaps = {
--             -- ["gd"] = {
--             --     desc = "Toggle file detail view",
--             --     callback = function()
--             --         detail = not detail
--             --         if detail then
--             --             require("oil").set_columns({ "permissions", "size", "mtime" })
--             --         else
--             --             require("oil").set_columns({ "icon" })
--             --         end
--             --     end,
--             -- },
--             ["g?"] = "actions.show_help",
--             ["<CR>"] = "actions.select",
--             ["<C-s>"] = "actions.select_vsplit",
--             ["<C-h>"] = "actions.select_split",
--             ["<C-t>"] = "actions.select_tab",
--             ["<C-p>"] = "actions.preview",
--             ["<C-c>"] = "actions.close",
--             ["<C-l>"] = "actions.refresh",
--             ["-"] = "actions.parent",
--             ["<BS>"] = "actions.parent",
--             ["_"] = "actions.open_cwd",
--             ["`"] = "actions.cd",
--             ["~"] = "actions.tcd",
--             ["gs"] = "actions.change_sort",
--             ["gx"] = "actions.open_external",
--             ["g."] = "actions.toggle_hidden",
--             ["g\\"] = "actions.toggle_trash",
--         },
--     })
--
--     vim.cmd([[hi! link WinBar StatusLine]])
--     vim.cmd([[hi! link WinBarNC StatusLineNC]])
-- end

require("lze").load({
    {
        "canola.nvim",
        for_cat = "general.extra",
        lazy = false,
        keys = {
            { "<leader>fd", "<cmd>Canola<CR>", noremap = true, mode = "n", },
        },
        after = function()
            vim.g.canola = {
                hidden = {
                    enabled = true,
                    patterns = { "^%." },
                    always = {},
                },
                columns = { "permissions", "owner", "group", "mtime", "ctime", "size", "icon" },
                keymaps = {
                    ["<l>"] = { callback = "actions.select", },
                    ["<h>"] = { callback = "actions.parent", },
                },
            }
        end,
    },
    { import = "myLuaConf.plugins.mini-base16" },
    { import = "myLuaConf.plugins.mini" },
    { import = "myLuaConf.plugins.treesitter" },
    { import = "myLuaConf.plugins.fold" },
    { import = "myLuaConf.plugins.org" },
    { import = "myLuaConf.plugins.edgy" },
    { import = "myLuaConf.plugins.img-clip" },
    { import = "myLuaConf.plugins.git.neogit" },
    {
        "mini.icons",
        for_cat = "general.mini",
        after = function()
            require("mini.icons").setup()
            MiniIcons.mock_nvim_web_devicons()
        end,
    },
    {
        "fff.nvim",
        for_cat = "general.extra",
        lazy = false,
        keys = {
            -- { "<leader><leader>", function() require('fff').find_files() end, desc = 'Find Files' },
            {
                "fG",
                function() require('fff').live_grep({ grep = { modes = { 'fuzzy', 'plain', 'regex' } } }) end,
                desc = 'File Grep',
            },
            {
                "fw",
                function() require('fff').live_grep_under_cursor() end,
                mode = { 'n', 'x' },
                desc = 'Search current word / selection',
            },
        },
        after = function()
            ---@class FFFItem
            ---@field name string
            ---@field path string
            ---@field relative_path string
            ---@field size number
            ---@field modified number
            ---@field total_frecency_score number
            ---@field modification_frecency_score number
            ---@field access_frecency_score number
            ---@field git_status string

            ---@class PickerItem
            ---@field text string
            ---@field path string
            ---@field score number

            ---@class FFFPickerState
            ---@field current_file_cache string
            local state = {}

            local ns_id = vim.api.nvim_create_namespace 'MiniPick FFFiles Picker'
            vim.api.nvim_set_hl(0, 'FFFileScore', { fg = '#FFFF00' })

            ---@param query string|nil
            ---@return PickerItem[]
            local function find(query)
                local file_picker = require 'fff.file_picker'

                query = query or ''
                ---@type FFFItem[]
                -- local fff_result = file_picker.search_files(query, 100, 4, state.current_file_cache, false)
                local fff_result = file_picker.search_files(
                    query,
                    state.current_file_cache, -- Arg 2: String (or nil)
                    100,                      -- Arg 3: Number
                    4,                        -- Arg 4: Number (usize)
                    nil                     -- Arg 5: Boolean/Nil
                )

                local items = {}
                for _, fff_item in ipairs(fff_result) do
                    local item = {
                        text = fff_item.relative_path,
                        path = fff_item.path,
                        score = fff_item.total_frecency_score,
                    }
                    table.insert(items, item)
                end

                return items
            end

            ---@param items PickerItem[]
            local function show(buf_id, items)
                local icon_data = {}

                -- Show items
                local items_to_show = {}
                for i, item in ipairs(items) do
                    local icon, hl, _ = MiniIcons.get('file', item.text)
                    icon_data[i] = { icon = icon, hl = hl }

                    items_to_show[i] = string.format('%s %s %d', icon, item.text, item.score)
                end
                vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, items_to_show)

                vim.api.nvim_buf_clear_namespace(buf_id, ns_id, 0, -1)

                local icon_extmark_opts = { hl_mode = 'combine', priority = 200 }
                for i, item in ipairs(items) do
                    -- Highlight Icons
                    icon_extmark_opts.hl_group = icon_data[i].hl
                    icon_extmark_opts.end_row, icon_extmark_opts.end_col = i - 1, 1
                    vim.api.nvim_buf_set_extmark(buf_id, ns_id, i - 1, 0, icon_extmark_opts)

                    -- Highlight score
                    local col = #items_to_show[i] - #tostring(item.score) - 3
                    icon_extmark_opts.hl_group = 'FFFileScore'
                    icon_extmark_opts.end_row, icon_extmark_opts.end_col = i - 1, #items_to_show[i]
                    vim.api.nvim_buf_set_extmark(buf_id, ns_id, i - 1, col, icon_extmark_opts)
                end
            end

            local function run()
                -- Setup fff.nvim
                local file_picker = require 'fff.file_picker'
                if not file_picker.is_initialized() then
                    local setup_success = file_picker.setup()
                    if not setup_success then
                        vim.notify('Could not setup fff.nvim', vim.log.levels.ERROR)
                        return
                    end
                end

                -- Cache current file to deprioritize in fff.nvim
                if not state.current_file_cache then
                    local current_buf = vim.api.nvim_get_current_buf()
                    if current_buf and vim.api.nvim_buf_is_valid(current_buf) then
                        local current_file = vim.api.nvim_buf_get_name(current_buf)
                        if current_file ~= '' and vim.fn.filereadable(current_file) == 1 then
                            local relative_path = vim.fs.relpath(vim.uv.cwd(), current_file)
                            state.current_file_cache = relative_path
                        else
                            state.current_file_cache = nil
                        end
                    end
                end

                -- Start picker
                MiniPick.start {
                    source = {
                        name = 'FFFiles',
                        items = find,
                        match = function(_, _, query)
                            local items = find(table.concat(query))
                            MiniPick.set_picker_items(items, { do_match = false })
                        end,
                        show = show,
                    },
                }

                state.current_file_cache = nil -- Reset cache
            end

            MiniPick.registry.fffiles = run

            vim.keymap.set('n', '<leader><space>', MiniPick.registry.fffiles)
        end,
    },

    -- {
    --     "markdown-preview.nvim",
    --     for_cat = "general.markdown",
    --     cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
    --     ft = "markdown",
    --     keys = {
    --         {
    --             "<leader>mp",
    --             "<cmd>MarkdownPreview <CR>",
    --             mode = { "n" },
    --             noremap = true,
    --             desc = "markdown preview",
    --         },
    --         {
    --             "<leader>ms",
    --             "<cmd>MarkdownPreviewStop <CR>",
    --             mode = { "n" },
    --             noremap = true,
    --             desc = "markdown preview stop",
    --         },
    --         {
    --             "<leader>mt",
    --             "<cmd>MarkdownPreviewToggle <CR>",
    --             mode = { "n" },
    --             noremap = true,
    --             desc = "markdown preview toggle",
    --         },
    --     },
    --     before = function()
    --         vim.g.mkdp_auto_close = 0
    --     end,
    -- },
    -- {
    --     "render-markdown.nvim",
    --     for_cat = "general.markdown",
    --     ft = "markdown",
    --     cmd = "RenderMarkdown",
    --     after = function()
    --         require("render-markdown").setup({
    --             render_modes = true,
    --             bullet = {
    --                 enabled = true,
    --                 render_modes = false,
    --                 icons = { "󰫶 ", "󱂉 " },
    --                 ordered_icons = function(ctx)
    --                     local value = vim.trim(ctx.value)
    --                     local index = tonumber(value:sub(1, #value - 1))
    --                     return ('%d.'):format(index > 1 and index or ctx.index)
    --                 end,
    --                 highlight = "RenderMarkdownBullet",
    --                 scope_highlight = {},
    --                 scope_priority = nil,
    --                 indent = 2,
    --                 left_pad = 2,
    --             },
    --             checkbox = {
    --                 enabled = true,
    --                 left_pad = 2,
    --                 indent = 2,
    --             },
    --             code = {
    --                 -- above = " ",
    --                 -- below = " ",
    --                 -- border = "thick",
    --                 -- language_pad = 2,
    --                 -- left_pad = 4,
    --                 position = "left",
    --                 -- right_pad = 6,
    --                 sign = false,
    --                 width = "full",
    --             },
    --             heading = {
    --                 border = false,
    --                 -- icons = {
    --                 --     -- "▼ ",
    --                 --     -- "▽ ",
    --                 --     -- "▼ ",
    --                 --     -- "▽ ",
    --                 --     -- "▼ ",
    --                 --     -- "▽ "
    --                 -- },
    --                 icons = function(ctx)
    --                     return table.concat(ctx.sections, '.') .. ' '
    --                 end,
    --                 position = "inline",
    --                 sign = false,
    --                 width = "full",
    --                 left_pad = -2,
    --                 backgrounds = { "",
    --                     "",
    --                     "",
    --                     "",
    --                     "",
    --                     "" },
    --             },
    --             -- heading = {
    --             --     width = "block",
    --             --     backgrounds = {
    --             --         "MiniStatusLineModeNormal",
    --             --         "MiniStatusLineModeInsert",
    --             --         "MiniStatusLineModeReplace",
    --             --         "MiniStatusLineModeVisual",
    --             --         "MiniStatusLineModeCommand",
    --             --         "MiniStatusLineModeOther",
    --             --     },
    --             --     sign = true,
    --             --     left_pad = 1,
    --             --     right_pad = 0,
    --             --     position = "right",
    --             --     icons = {
    --             --         "",
    --             --         "",
    --             --         "",
    --             --         "",
    --             --         "",
    --             --         "",
    --             --     },
    --             -- },
    --             indent = {
    --                 enabled = true,
    --                 skip_heading = false,
    --                 highlight = "",
    --                 icon = "  ",
    --             },
    --             paragraph = {
    --                 enabled = true,
    --                 -- render_modes = false,
    --                 -- left_margin = 0,
    --                 indent = 2,
    --                 -- min_width = 0,
    --             },
    --             signs = {
    --                 enabled = false,
    --             },
    --         })
    --     end,
    -- },
    {
        "nvim-highlight-colors",
        for_cat = "general.extra",
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
        "vim-eunuch",
        for_cat = "general.always",
        cmd = {
            "SudoEdit",
            "SudoWrite",
        },
    },
    {
        "promise-async",
        for_cat = "general.extra",
        dep_of = "nvim-ufo",
    },
    -- {
    --     "undotree",
    --     for_cat = "general.extra",
    --     cmd = { "UndotreeToggle", "UndotreeHide", "UndotreeShow", "UndotreeFocus", "UndotreePersistUndo" },
    --     keys = { { "<leader>u", "<cmd>UndotreeToggle<CR>", mode = { "n" }, desc = "Undo Tree" } },
    --     before = function(_)
    --         vim.g.undotree_WindowLayout = 1
    --         vim.g.undotree_SplitWidth = 40
    --     end,
    -- },
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
    --     after = function()
    --         require("fidget").setup({
    --             notification = {
    --                 window = {
    --                     border = "none",
    --                     x_padding = 1,
    --                     y_padding = 1,
    --                 },
    --             },
    --         })
    --     end,
    -- },
})
