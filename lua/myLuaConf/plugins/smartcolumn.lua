return {
    {
        "smartcolumn.nvim",
        for_cat = "general.always",
        after = function()
            require("smartcolumn").setup({
                colorcolumn = "100",
                disabled_filetypes = { "NvimTree", "lazy", "mason", "help", "checkhealth", "lspinfo", "noice", "Trouble", "fish", "zsh", "snacks_dashboard" },
            })
        end
    },
}
