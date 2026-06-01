return {
    {
        "img-clip.nvim",
        for_cat = "general.extra",
        event = "DeferredUIEnter",
        after = function()
            require("img-clip").setup({
            })

            vim.keymap.set({ "n", "i" }, "<leader>vp", function()
                local pasted_image = require("img-clip").paste_image()
                if pasted_image then
                    -- "Update" saves only if the buffer has been modified since the last save
                    vim.cmd("silent! update")
                    -- Get the current line
                    local line = vim.api.nvim_get_current_line()
                    -- Move cursor to end of line
                    vim.api.nvim_win_set_cursor(0, { vim.api.nvim_win_get_cursor(0)[1], #line })
                    -- I reload the file, otherwise I cannot view the image after pasted
                    vim.cmd("edit!")
                end
            end, { desc = "[P]Paste image from system clipboard" })
        end,
    },
}
