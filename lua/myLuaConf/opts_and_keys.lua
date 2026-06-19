-- NOTE: These 2 need to be set up before any plugins are loaded.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Set highlight on search
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

vim.o.filetype = "on"
vim.o.showmode = false

vim.o.swapfile = false

-- Indent
-- vim.o.smarttab = true
vim.opt.cpoptions:append('I')
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.autoindent = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

-- stops line wrapping from being confusing
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'
vim.wo.relativenumber = true

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menu,preview,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

vim.o.cursorline = true
vim.o.cursorlineopt = 'both'

vim.o.conceallevel = 1

-- vim.o.winborder = 'single'
-- [[ Disable auto comment on enter ]]
-- See :help formatoptions
vim.api.nvim_create_autocmd("FileType", {
	desc = "remove formatoptions",
	callback = function()
		vim.opt.formatoptions:remove({ "c", "r", "o" })
	end,
})

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = '*',
})

vim.g.netrw_liststyle = 0
vim.g.netrw_banner = 0

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set("v", "<S-Down>", ":m '>+1<CR>gv=gv", { desc = 'Moves Line Down' })
vim.keymap.set("v", "<S-Up>", ":m '<-2<CR>gv=gv", { desc = 'Moves Line Up' })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = 'Scroll Down' })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = 'Scroll Up' })
vim.keymap.set("n", "n", "nzzzv", { desc = 'Next Search Result' })
vim.keymap.set("n", "N", "Nzzzv", { desc = 'Previous Search Result' })
vim.keymap.set("n", "<S-Down>", "mzJ`z", { desc = 'Keep cursor at line start' })

-- Remap for dealing with word wrap
vim.keymap.set('n', '<Up>', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', '<Down>', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>cx', function()
	if vim.fn.getloclist(0, { winid = 1 }).winid ~= 0 then
		vim.cmd('lclose')
	else
		vim.diagnostic.setloclist()
	end
end, { desc = 'Open diagnostics list' })

-- You should instead use these keybindings so that they are still easy to use, but dont conflict
vim.keymap.set({ "v", "x", "n" }, '<leader>y', '"+y', { noremap = true, silent = true, desc = 'Yank to clipboard' })
vim.keymap.set({ "n", "v", "x" }, '<leader>Y', '"+yy', { noremap = true, silent = true, desc = 'Yank line to clipboard' })
vim.keymap.set({ "n", "v", "x" }, '<C-a>', 'gg0vG$', { noremap = true, silent = true, desc = 'Select all' })
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>p', '"+p', { noremap = true, silent = true, desc = 'Paste from clipboard' })
vim.keymap.set("x", "<leader>P", '"_dP',
	{ noremap = true, silent = true, desc = 'Paste over selection without erasing unnamed register' })

vim.keymap.set("n", '<leader>ts', '<cmd>set spell!<Cr>', { desc = 'Toggle Spellcheck' })
vim.keymap.set("n", '<leader>tl', '<cmd>set rnu!<CR>')

-- harpoon but builtin
-- vim.keymap.set('n', "<leader><cr>", ":argu<cr>:args<cr>", { desc = "go to last used arglist file" })
-- vim.keymap.set('n', "<leader>1", ":rew<CR>:args<CR>", { desc = "first arg buffer" })
-- vim.keymap.set('n', "<leader>2", ":argu 2<CR>:args<CR>", { desc = "second arg buffer" })
-- vim.keymap.set('n', "<leader>3", ":argu 3<CR>:args<CR>", { desc = "third arg buffer" })
-- vim.keymap.set('n', "<leader>4", ":argu 4<CR>:args<CR>", { desc = "fourth arg buffer" })
-- vim.keymap.set('n', "<leader>l", ":args<CR>", { desc = "list arglist" })
-- vim.keymap.set('n', "<leader>aa", "<cmd>$argadd %<bar>argded<bar>args<cr>", { desc = "add to arglist" })
-- vim.keymap.set('n', "<leader>ad", "<cmd>argdelete %<bar>args<cr>", { desc = "delete from arglist" })
-- vim.keymap.set('n', "<leader>ac", "<cmd>argdelete *<CR><C-L>", { desc = "clear arglist" })
