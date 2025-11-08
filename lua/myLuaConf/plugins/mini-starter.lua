return {
    {
        "mini.starter",
        for_cat = "general.always",
        -- event = "VimEnter",
        -- lazy = false,
        after = function()
            local starter = require("mini.starter")
            require("mini.starter").setup({
                evaluate_single = true,
                footer = "",
                items = {
                    -- starter.sections.sessions(77, true),
                    starter.sections.recent_files(5, false, false),
                    starter.sections.builtin_actions(),
                },
                content_hooks = {
                    -- function(content)
                    --     local blank_content_line = { { type = 'empty', string = '' } }
                    --     local section_coords = starter.content_coords(content, 'section')
                    --     -- Insert backwards to not affect coordinates
                    --     for i = #section_coords, 1, -1 do
                    --         table.insert(content, section_coords[i].line + 1, blank_content_line)
                    --     end
                    --     return content
                    -- end,
                    starter.gen_hook.adding_bullet(),
                    starter.gen_hook.aligning('center', 'center'),
                    starter.gen_hook.padding(3, 2),
                },
            })

            vim.api.nvim_create_autocmd('VimEnter', {
                once = true, -- key line: ensures it runs only once
                callback = function()
                    -- no files, no stdin, and not re-entering after a quit
                    if vim.fn.argc() == 0 and vim.fn.line2byte('$') == -1 then
                        -- only open if we're not already in a starter buffer
                        local bufname = vim.api.nvim_buf_get_name(0)
                        if bufname == '' or bufname:match('^%[No Name%]$') then
                            require('mini.starter').open()
                        end
                    end
                end,
            })
        end
    },
}
