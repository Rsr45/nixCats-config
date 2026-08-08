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


-- General ====================================================================
vim.g.mapleader   = ' '                              -- Use `<Space>` as a leader key

vim.o.mouse       = 'a'                              -- Enable mouse
vim.o.mousescroll = 'ver:25,hor:6'                   -- Customize mouse scroll
vim.o.switchbuf   = 'usetab'                         -- Use already opened buffers when switching
vim.o.undofile    = true                             -- Enable persistent undo

vim.o.shada       = "'100,<50,s10,:1000,/100,@100,h" -- Limit ShaDa file (for startup)

-- Enable all filetype plugins and syntax
vim.cmd('filetype plugin indent on')
if vim.fn.exists('syntax_on') ~= 1 then vim.cmd('syntax enable') end

-- UI =========================================================================
vim.o.breakindent    = true                -- Indent wrapped lines to match line start
vim.o.breakindentopt = 'list:-1'           -- Add padding for lists (if 'wrap' is set)
vim.o.colorcolumn    = '+1'                -- Draw column on the right of maximum width
vim.o.cursorline     = true                -- Enable current line highlighting
vim.o.linebreak      = true                -- Wrap lines at 'breakat' (if 'wrap' is set)
vim.o.list           = true                -- Show helpful text indicators
vim.o.number         = true                -- Show line numbers
vim.o.pumheight      = 10                  -- Make popup menu smaller
vim.o.ruler          = false               -- Don't show cursor coordinates
vim.o.shortmess      = 'CFOSWaco'          -- Disable some built-in completion messages
vim.o.showmode       = false               -- Don't show mode in command line
vim.o.signcolumn     = 'yes'               -- Always show signcolumn (less flicker)
vim.o.splitbelow     = true                -- Horizontal splits will be below
vim.o.splitkeep      = 'screen'            -- Reduce scroll during window split
vim.o.splitright     = true                -- Vertical splits will be to the right
vim.o.wrap           = false               -- Don't visually wrap lines (toggle with \w)

vim.o.cursorlineopt  = 'screenline,number' -- Show cursor line per screen line

-- Special UI symbols
vim.o.fillchars      = 'eob: ,fold:╌'
vim.o.listchars      = 'extends:…,nbsp:␣,precedes:…,tab:> '

-- Neovim version specific
if vim.fn.has('nvim-0.10') == 0 then
    vim.o.termguicolors = true
end

if vim.fn.has('nvim-0.10') == 1 then
    vim.o.foldtext = '' -- Show text under fold with its highlighting
end

if vim.fn.has('nvim-0.11') == 1 then
    vim.o.winborder = 'bold' -- Use border in floating windows
end

if vim.fn.has('nvim-0.12') == 1 then
    vim.o.pummaxwidth = 100 -- Limit maximum width of popup menu
    vim.o.completetimeout = 100

    vim.o.pumborder = 'bold' -- Use border in built-in completion menu

    require('vim._core.ui2').enable({ enable = true })
end

if vim.fn.has('nvim-0.13') == 1 then
    -- Try it out. Probably not a good idea since the "put" action has visible
    -- side effects so the temporary highlight is more distracting than useful.
    vim.cmd("autocmd TextPutPost * silent! lua vim.hl.hl_op()")

    vim.o.shortmess = 'CFOSWacou' -- Add `u` flag to disable undo/redo messages

    vim.o.updatetime = 200        -- Ensure fast `current_line` diagnostic renders
end

-- Editing ====================================================================
vim.o.autoindent    = true                  -- Use auto indent
vim.o.expandtab     = true                  -- Convert tabs to spaces
vim.o.formatoptions = 'rqnl1j'              -- Improve comment editing
vim.o.ignorecase    = true                  -- Ignore case during search
vim.o.incsearch     = true                  -- Show search matches while typing
vim.o.infercase     = true                  -- Infer case in built-in completion
vim.o.shiftwidth    = 2                     -- Use this number of spaces for indentation
vim.o.smartcase     = true                  -- Respect case if search pattern has upper case
vim.o.smartindent   = true                  -- Make indenting smart
vim.o.spelllang     = 'en,uk,ru'         -- Define spelling dictionaries
vim.o.spelloptions  = 'camel'               -- Treat camelCase word parts as separate words
vim.o.tabstop       = 2                     -- Show tab as this number of spaces
vim.o.virtualedit   = 'block'               -- Allow going past end of line in blockwise mode

vim.o.iskeyword     = '@,48-57,_,192-255,-' -- Treat dash as `word` textobject part
-- vim.o.dictionary = vim.fn.stdpath('config') .. '/misc/dict/english.txt' -- Use specific dictionaries

-- Pattern for a start of 'numbered' list (used in `gw`). This reads as
-- "Start of list item is: at least one special character (digit, -, +, *)
-- possibly followed by punctuation (. or `)`) followed by at least one space".
vim.o.formatlistpat = [[^\s*[0-9\-\+\*]\+[\.\)]*\s\+]]

-- Built-in completion
vim.o.complete      = '.,w,b,kspell'     -- Use less sources
vim.o.completeopt   = 'menuone,noselect' -- Use custom behavior

if vim.fn.has('nvim-0.11') == 1 then
    vim.o.completeopt = 'menuone,noselect,fuzzy,nosort'
end

-- Cyrillic keyboard layout
-- local langmap_keys = {
--   'ёЁ;`~', '№;#',
--   'йЙ;qQ', 'цЦ;wW', 'уУ;eE', 'кК;rR', 'еЕ;tT', 'нН;yY', 'гГ;uU', 'шШ;iI', 'щЩ;oO', 'зЗ;pP', 'хХ;[{', 'ъЪ;]}',
--   'фФ;aA', 'ыЫ;sS', 'вВ;dD', 'аА;fF', 'пП;gG', 'рР;hH', 'оО;jJ', 'лЛ;kK', 'дД;lL', [[жЖ;\;:]], [[эЭ;'\"]],
--   'яЯ;zZ', 'чЧ;xX', 'сС;cC', 'мМ;vV', 'иИ;bB', 'тТ;nN', 'ьЬ;mM', [[бБ;\,<]], 'юЮ;.>',
-- }
-- vim.o.langmap = table.concat(langmap_keys, ',')

-- Autocommands ===============================================================
-- Don't auto-wrap comments and don't insert comment leader after hitting 'o'.
-- Do on `FileType` to always override these changes from filetype plugins.
-- local ensure_fo = function() vim.cmd('setlocal formatoptions-=c formatoptions-=o') end
-- Config.new_autocmd('FileType', '*', ensure_fo, "Proper 'formatoptions'")

-- Diagnostics ================================================================
local diagnostic_opts = {
    -- Show signs on top of any other sign, but only for warnings and errors
    signs = { priority = 9999, severity = { min = 'WARN', max = 'ERROR' } },

    -- Show all diagnostics as underline (for their meessages type `<Leader>ld`)
    underline = { severity = { min = 'HINT', max = 'ERROR' } },

    -- Show more details immediately only for errors at current line end
    virtual_lines = false,
    virtual_text = {
        current_line = true,
        severity = { min = 'ERROR', max = 'ERROR' },
    },

    -- Don't update diagnostics when typing
    update_in_insert = false,
}

vim.diagnostic.config(diagnostic_opts)
