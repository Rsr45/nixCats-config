local load_w_after = function(name)
    vim.cmd.packadd(name)
    vim.cmd.packadd(name .. '/after')
end

return {
    {
        "cmp-cmdline",
        for_cat = "general.blink",
        on_plugin = { "blink.cmp" },
        load = load_w_after,
    },
    {
        "blink.compat",
        for_cat = "general.blink",
        dep_of = { "cmp-cmdline" },
    },
    {
        "luasnip",
        for_cat = "general.blink",
        dep_of = { "blink.cmp" },
        after = function(_)
            local luasnip = require 'luasnip'
            require('luasnip.loaders.from_vscode').lazy_load()
            luasnip.config.setup {}

            local ls = require('luasnip')

            vim.keymap.set({ "i", "s" }, "<M-n>", function()
                if ls.choice_active() then
                    ls.change_choice(1)
                end
            end)
        end,
    },
    {
        "blink.cmp",
        for_cat = "general.blink",
        event = "DeferredUIEnter",
        after = function(_)
            require("blink.cmp").setup({
                -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
                -- See :h blink-cmp-config-keymap for configuring keymaps
                keymap = {
                    preset = 'default',

                    ['<Up>'] = {},
                    ['<Down>'] = {},
                    ['<Left>'] = {},
                    ['<Right>'] = {},
                },
                cmdline = {
                    enabled = true,
                    keymap = { preset = 'inherit' },
                    completion = {
                        menu = {
                            auto_show = true,
                        },
                    },
                    sources = function()
                        local type = vim.fn.getcmdtype()
                        -- Search forward and backward
                        if type == '/' or type == '?' then return { 'buffer' } end
                        -- Commands
                        if type == ':' or type == '@' then return { 'cmdline', 'cmp_cmdline' } end
                        return {}
                    end,
                },
                fuzzy = {
                    sorts = {
                        'exact',
                        -- defaults
                        'score',
                        'sort_text',
                    },
                },
                signature = {
                    enabled = true,
                    window = {
                        show_documentation = true,
                        border = 'single',
                    },
                },
                completion = {
                    ghost_text = {
                        enabled = false,
                    },
                    menu = {
                        border = 'single',
                        draw = {
                            columns = { { 'item_idx' }, { "label", "label_description", gap = 1 }, { "kind_icon", "kind", gap = 1 } },
                            treesitter = { 'lsp' },
                            components = {
                                kind_icon = {
                                    text = function(ctx)
                                        local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
                                        return kind_icon
                                    end,
                                    -- (optional) use highlights from mini.icons
                                    highlight = function(ctx)
                                        local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                                        return hl
                                    end,
                                },
                                kind = {
                                    -- (optional) use highlights from mini.icons
                                    highlight = function(ctx)
                                        local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                                        return hl
                                    end,
                                },
                                item_idx = {
                                    text = function(ctx) return tostring(ctx.idx) end,
                                    highlight = 'BlinkCmpItemIdx' -- optional, only if you want to change its color
                                }
                            },
                        },
                    },
                    documentation = {
                        auto_show = true,
                        auto_show_delay_ms = 1000,
                        window = { border = 'single' },
                    },
                },
                snippets = {
                    preset = 'luasnip',
                    active = function(filter)
                        local snippet = require "luasnip"
                        local blink = require "blink.cmp"
                        if snippet.in_snippet() and not blink.is_visible() then
                            return true
                        else
                            if not snippet.in_snippet() and vim.fn.mode() == "n" then snippet.unlink_current() end
                            return false
                        end
                    end,
                },
                sources = {
                    default = { 'lsp', 'path', 'snippets', 'buffer', 'omni' },
                    providers = {
                        path = {
                            score_offset = 50,
                        },
                        lsp = {
                            score_offset = 40,
                        },
                        snippets = {
                            score_offset = 40,
                        },
                        cmp_cmdline = {
                            name = 'cmp_cmdline',
                            module = 'blink.compat.source',
                            score_offset = -100,
                            opts = {
                                cmp_name = 'cmdline',
                            },
                        },
                    },
                },
            })
        end,
    },
}
