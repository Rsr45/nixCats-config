return {
    {
        "mini.nvim",
        for_cat = "general.mini",
        event = "DeferredUIEnter",
        lazy = false,
        keys = {
            { "<leader>bt", function() MiniTrailspace.trim() end,            desc = "Trim" },
            { "<leader>bT", function() MiniTrailspace.trim_last_lines() end, desc = "Trim last lines" },
            { "<leader>ct", function() MiniTrailspace.trim() end,            desc = "Trim" },
            { "<leader>cT", function() MiniTrailspace.trim_last_lines() end, desc = "Trim last lines" },
            { "<leader>bd", mode = { "n" },                                  "<cmd>lua MiniBufremove.delete()<CR>",                               desc = "Kill buffer" },
            { "<leader>bk", mode = { "n" },                                  "<cmd>lua MiniBufremove.delete()<CR>",                               desc = "Kill buffer" },

            -- pick
            { "<leader>fb", mode = { "n" },                                  "<cmd>lua MiniPick.builtin.buffers()<CR>",                           desc = "Find Buffer", },
            { "<leader>fs", mode = { "n" },                                  "<cmd>Pick buf_lines<CR>",                                           desc = "File Grep", },
            { "<leader>fg", mode = { "n" },                                  "<cmd>lua MiniPick.builtin.grep_live()<CR>",                         desc = "Grep", },
            { "<leader>ff", mode = { "n" },                                  "<cmd>lua MiniPick.builtin.files()<CR>",                             desc = "Find File", },
            { "<leader>fF", mode = { "n" },                                  "<cmd>lua MiniPick.builtin.files({ dir = fn.expand('%:p:h') })<CR>", desc = "Find File", },
            { "<leader>fe", mode = { "n" },                                  "<cmd>lua MiniFiles.open()<CR>",                                     desc = "File Ex", },
        },
        after = function()
            require("mini.ai").setup()
            require("mini.align").setup()
            -- require("mini.animate").setup()
            require("mini.pairs").setup()


            require("mini.basics").setup()
            require("mini.bracketed").setup()
            require("mini.bufremove").setup()

            local miniclue = require('mini.clue')
            require("mini.clue").setup({
                clues = {
                    miniclue.gen_clues.builtin_completion(),
                    miniclue.gen_clues.g(),
                    miniclue.gen_clues.marks(),
                    miniclue.gen_clues.registers(),
                    miniclue.gen_clues.square_brackets(),
                    miniclue.gen_clues.windows({ submode_resize = true }),
                    miniclue.gen_clues.z(),
                },
                triggers = {
                    { mode = { 'n', 'x' }, keys = '<Leader>' }, -- Leader triggers
                    { mode = 'n',          keys = '\\' },       -- mini.basics
                    { mode = { 'n', 'x' }, keys = '[' },        -- mini.bracketed
                    { mode = { 'n', 'x' }, keys = ']' },
                    { mode = 'i',          keys = '<C-x>' },    -- Built-in completion
                    { mode = { 'n', 'x' }, keys = 'g' },        -- `g` key
                    { mode = { 'n', 'x' }, keys = "'" },        -- Marks
                    { mode = { 'n', 'x' }, keys = '`' },
                    { mode = { 'n', 'x' }, keys = '"' },        -- Registers
                    { mode = { 'i', 'c' }, keys = '<C-r>' },
                    { mode = 'n',          keys = '<C-w>' },    -- Window commands
                    { mode = { 'n', 'x' }, keys = 's' },        -- `s` key
                    { mode = { 'n', 'x' }, keys = 'z' },        -- `z` key
                },
            })
            -- require("mini.cmdline").setup()

            -- appearance
            local words = { red = '#ff0000', green = '#00ff00', blue = '#0000ff' }
            local word_color_group = function(_, match)
                local hex = words[match]
                if hex == nil then return nil end
                return MiniHipatterns.compute_hex_color_group(hex, 'bg')
            end

            local hipatterns = require("mini.hipatterns")
            require("mini.hipatterns").setup({
                highlighters = {
                    -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
                    fixme      = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
                    hack       = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
                    todo       = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
                    note       = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },

                    -- denote.el TODO find a better way to integrate the custom dired mod.
                    -- id         = { pattern = '@@[^==%--__]+', group = 'MiniHipatternsNote' },
                    -- signature  = { pattern = '==[^@@%--__]+', group = 'MiniHipatternsFixme' },
                    -- keywords   = { pattern = '__[^@@%--==]+', group = 'MiniHipatternsHack' },

                    -- Highlight hex color strings (`#292929`) using that color
                    hex_color  = hipatterns.gen_highlighter.hex_color(),
                    word_color = { pattern = '%S+', group = word_color_group },
                },
            })

            -- require("mini.colors").setup() -- Tweak and save any color scheme
            -- require('mini.base16').setup() -- Base16 colorscheme creation
            -- require("mini.hues").setup() -- Generate configurable color scheme

            require("mini.comment").setup()
            require("mini.completion").setup()
            require("mini.cursorword").setup()
            require("mini.deps").setup()
            require("mini.diff").setup()
            -- require("mini.doc").setup()
            require("mini.extra").setup()

            require("mini.files").setup({
                windows = { preview = true }
            })
            require("mini.fuzzy").setup()
            require("mini.git").setup()



            -- require("mini.icons").setup()
            -- require("mini.indentscope").setup()
            -- require("mini.init").setup()
            -- require("mini.input").setup()
            require("mini.jump").setup()
            require("mini.jump2d").setup()
            require("mini.keymap").setup()
            -- require("mini.map").setup()
            require("mini.misc").setup()
            -- require("mini.move").setup()
            require("mini.notify").setup()
            require("mini.operators").setup()
            require("mini.pick").setup()
            -- require("mini.sessions").setup()
            require("mini.snippets").setup()
            -- require("mini.splitjoin").setup()
            -- require("mini.starter").setup()
            require("mini.statusline").setup()

            vim.keymap.set({ "n", "v", "x" }, "S", "<Nop>")
            vim.keymap.set({ "n", "v", "x" }, "s", "<Nop>")
            require("mini.surround").setup({
                mappings = {
                    add = "sa",            -- Add surrounding in Normal and Visual modes
                    delete = "sd",         -- Delete surrounding
                    find = "sf",           -- Find surrounding (to the right)
                    find_left = "sF",      -- Find surrounding (to the left)
                    highlight = "sh",      -- Highlight surrounding
                    replace = "sr",        -- Replace surrounding
                    update_n_lines = "sn", -- Update `n_lines`
                },
            })

            -- require("mini.tabline").setup()
            -- require("mini.test").setup()
            require("mini.trailspace").setup()
            -- require("mini.visits").setup()



            -- cool as fuck
            -- https://github.com/nvim-mini/mini.nvim/discussions/2523
            local fn, fs, uv, api = vim.fn, vim.fs, vim.uv, vim.api
            local pick = require("mini.pick")

            ---convert fs_stat size to string with units
            local size_str = function(size)
                if not size then return "" end
                local KB = 1000
                local MB = KB * KB
                local GB = KB * KB * KB
                local TB = KB * KB * KB * KB
                local out = ""
                if size < KB then
                    out = ("%s"):format(size)
                elseif size < MB then
                    out = ("%.1fk"):format(size / KB)
                elseif size < GB then
                    out = ("%.1fM"):format(size / MB)
                elseif size < TB then
                    out = ("%.1fG"):format(size / GB)
                else
                    out = ("%.1fT"):format(size / TB)
                end
                return out
            end

            ---convert fs_stat octal "mode" number to permissions string, e.g. 604 -> -rw----r--
            local permissions_str = function(type, mode)
                if not mode then return string.rep("-", 10) end
                type = ({ directory = "d", link = "l" })[type] or "-"
                local octal_str = ("%03o"):format(mode % (8 * 8 * 8)) -- keep bottom 3 octal-digits
                local octal_map = {
                    ["0"] = "---",
                    ["1"] = "--x",
                    ["2"] = "-w-",
                    ["3"] = "-wx",
                    ["4"] = "r--",
                    ["5"] = "r-x",
                    ["6"] = "rw-",
                    ["7"] = "rwx",
                }
                local user = octal_map[octal_str:sub(1, 1)]
                local group = octal_map[octal_str:sub(2, 2)]
                local other = octal_map[octal_str:sub(3, 3)]
                return type .. user .. group .. other
            end

            ---convert fs_stat mtime to "last modified" string
            local modified_str = function(mtime)
                if not mtime then return "" end
                return fn.strftime("%b %d %H:%M", mtime.sec)
            end

            ---create an array of items for picker, will be called
            ---for each new directory visited during a picker session
            ---NOTE: actual items are returned as .items field of the returned table
            local get_dir_items = function(dirname)
                if not dirname then return { items = {}, widths = {} } end

                -- while we make items, also compute max length of text and size
                -- so we can arrange data into neatly aligned columns in custom show()
                local text_col_width = 0
                local size_col_width = 0
                local items = vim
                    .iter(fs.dir(dirname))
                    :map(function(name, type)
                        local path = fs.joinpath(dirname, name)
                        local stat = uv.fs_stat(path) or {}
                        local text = type == "directory" and name .. "/" or name
                        local size = size_str(stat.size)
                        text_col_width = math.max(text_col_width, #text)
                        size_col_width = math.max(size_col_width, #size)
                        return {
                            text = text,
                            path = path,
                            type = type,
                            size = size_str(stat.size),
                            permissions = permissions_str(type, stat.mode),
                            modified = modified_str(stat.mtime),
                        }
                    end)
                    :totable()

                return { items = items, widths = { text = text_col_width, size = size_col_width } }
            end


            -- path helpers --------------------------------------------------------------
            local normalized = function(path)
                return path and fs.normalize(fs.abspath(path))
            end

            local query_to_path = function(query)
                local path = table.concat(query)
                if vim.trim(path) == "" then return false end
                return fs.abspath(path)
            end

            local query_to_dirname = function(query)
                local path = table.concat(query)
                if vim.trim(path) == "" then return false end
                local dirname = path == "~" and fs.dirname(fn.expand(path)) or fs.dirname(path)
                return normalized(dirname)
            end

            local query_tail = function(query)
                local path = query_to_path(query)
                local tail = path and fs.basename(path) or ""
                return vim.split(tail, "")
            end


            -- picker implementation -----------------------------------------------------
            local CACHE_STUB = { items = {}, widths = {} }

            local find_file = function(local_opts, opts)
                local_opts = vim.tbl_extend("force", { dir = fn.getcwd() }, local_opts or {})
                local initial_dir = normalized(local_opts.dir)
                vim.schedule(function()
                    pick.set_picker_query(vim.split(fn.fnamemodify(initial_dir, ":~") .. "/", ""))
                end)

                -- `items_cache` is a table keyed by normalized directory paths
                -- NOTE: using `[false]` as a special key to stub empty lookups,
                -- which happens when query is empty
                local items_cache = { [false] = CACHE_STUB }
                items_cache[initial_dir] = get_dir_items(initial_dir)
                local items = items_cache[initial_dir].items

                -- stack helpers -----------------------------------------------------------
                -- This is just a tiny "stack" implementation to help with implementing the
                -- "presssing ~ or / resets query to list home or root directory" feature.
                -- The idea is pressing a "~" or "/" trigger with the right conditions will
                -- push the current query to a "history" stack and reset the query, and then
                -- reaching an empty query (by typing backspace or however) will restore
                -- a saved query from the top of the stack if it exists.
                local query_history_stack = {}
                local stack_pop = function()
                    return table.remove(query_history_stack)
                end
                local stack_push = function(query)
                    local top = query_history_stack[#query_history_stack]
                    if top and table.concat(top) == table.concat(query) then return end
                    table.insert(query_history_stack, query)
                    return query
                end
                local push_to_stack_and_reset_query = function(query)
                    local trigger_char = query[#query]
                    query[#query] = nil -- don't want to save the trigger char to saved query in history
                    stack_push(query)
                    pick.set_picker_query({ trigger_char })
                end
                ----------------------------------------------------------------------------

                local last_dir = initial_dir
                local match = function(stritems, inds, query)
                    -- restore query on top of stack if we hit empty query
                    if #query == 0 then
                        local last_query = stack_pop()
                        if last_query then
                            pick.set_picker_query(last_query)
                            return
                        end
                    end

                    -- pressing "~" anywhere during a query should immediatlely bring you home
                    -- NOTE: excluding cases with repetition like `query == { "~", "~", "~" }`
                    if #query > 1 and query[#query] == "~" and query[#query - 1] ~= "~" then
                        push_to_stack_and_reset_query(query)
                        return
                    end

                    -- pressing "/" only when last query char is "/" should bring you to root
                    -- meaning the last to chars of the query should be "//"
                    if #query > 1 and query[#query] == "/" and query[#query - 1] == "/" then
                        if table.concat(query) ~= "//" then
                            push_to_stack_and_reset_query(query)
                        else
                            -- NOTE: I'm excluding the case where you type "/" when `query == { "/" }`
                            -- i.e. repeating consecutive "/" chars does not add an empty "/" to the query
                            -- stack. This differs from Emacs behavior, but I think it's a lot better.
                            pick.set_picker_query({ "/" })
                        end
                        return
                    end

                    local current_dir = query_to_dirname(query)
                    if current_dir ~= last_dir then
                        last_dir = current_dir
                        -- if `current_dir == false`, we hit our items_cache[false] stub,
                        -- which is {} (truthy), so items will become {}, otherwise compute and cache new items
                        if not items_cache[current_dir] then items_cache[current_dir] = get_dir_items(current_dir) end
                        pick.set_picker_items(items_cache[current_dir].items, { do_match = true })
                        return
                    end

                    return pick.default_match(stritems, inds, query_tail(query))
                end

                local show = function(buf_id, items_to_show, query)
                    pick.default_show(buf_id, items_to_show, query_tail(query), { show_icons = true })

                    local ns = api.nvim_create_namespace("find-file-picker")
                    api.nvim_buf_clear_namespace(buf_id, ns, 0, -1)
                    local extmark = function(i, text, hl, extmark_opts)
                        api.nvim_buf_set_extmark(buf_id, ns, i - 1, 0, {
                            virt_text = { { text, hl } },
                            virt_text_pos = extmark_opts.virt_text_pos,
                            virt_text_win_col = extmark_opts.virt_text_win_col,
                            hl_mode = "combine",
                        })
                    end
                    local col_widths = items_cache[query_to_dirname(query)].widths
                    -- the numbers are kinda magic here...
                    -- 9 because that's the width of "%6s   " format string
                    -- 4 beacuse the text is prefixed with icons so 2 for icon and 2 for extra space after text
                    -- 40 because it looks alright as default offset
                    -- NOTE: an alternative would be to truncate filenames if width too long instead of moving columns
                    local permissions_offset = math.max(9 + (col_widths.text or 0) + 4, 40)
                    for i, item in ipairs(items_to_show) do
                        extmark(i, ("%6s   "):format(item.size), "String", { virt_text_pos = "inline" })
                        extmark(i, item.permissions, "Number", { virt_text_win_col = permissions_offset })
                        extmark(i, item.modified, "Comment", { virt_text_win_col = permissions_offset + 20 })
                    end
                end

                local custom_choose = function()
                    local current = pick.get_picker_matches().current
                    if current then
                        pick.default_choose(current)
                        return true
                    end
                    local query = pick.get_picker_query()
                    local path = query_to_path(query)
                    -- NOTE: needs to be scheduled so picker returns to target window and THEN calls :edit
                    vim.schedule(function() vim.cmd("edit " .. path) end)
                    return true
                end

                local custom_tab_complete = function()
                    local current = pick.get_picker_matches().current
                    if not current then return end

                    local path = fn.fnamemodify(current.path, ":p:~")
                    local query = vim.split(path, "")
                    pick.set_picker_query(query)
                end

                -- default opts
                opts = vim.tbl_deep_extend("keep", opts or {}, {
                    window = { prompt_prefix = " Search: " },
                    source = { name = "Find File" },
                    mappings = {
                        choose = "", -- to suppress overwrite <CR> warning
                        custom_choose = { char = "<CR>", func = custom_choose },
                        custom_tab_complete = { char = "<Tab>", func = custom_tab_complete },
                    },
                })
                -- mandatory opts
                opts = vim.tbl_deep_extend("force", opts, {
                    options = { use_cache = false },
                    source = { items = items, match = match, show = show },
                })
                return pick.start(opts)
            end

            pick.registry["find_file"] = find_file
            -- vim.keymap.set("n", "<Leader>ff", function() pick.registry.find_file() end)
            -- vim.keymap.set("n", "<Leader>fF", function() pick.registry.find_file({ dir = fn.expand("%:p:h") }) end)
        end,
    },
    -- {
    --     "mini.indentscope",
    --     for_cat = "general.mini",
    --     after = function()
    --         require("mini.indentscope").setup({
    --             draw = {
    --                 animation = require('mini.indentscope').gen_animation.none(),
    --             },
    --             symbol = "┆",
    --             options = {
    --                 try_as_border = true,
    --             },
    --         })
    --         -- neopywal fix
    --         vim.cmd([[hi! link MiniIndentscopeSymbol ModeMsg]])
    --     end
    -- },
}
