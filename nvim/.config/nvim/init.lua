--- Basic Options --------------------------------
vim.opt.tabstop = 4
vim.opt.shiftwidth = 0
vim.opt.expandtab = true

vim.opt.number = true
vim.opt.hlsearch = false

--vim.opt.clipboard = 'unnamedplus'
--vim.opt.spelllang = 'en'
--vim.opt.iskeyword = vim.opt.iskeyword + '-'
vim.opt.timeoutlen = 200
--------------------------------------------------


--- Mappings -------------------------------------
vim.g.mapleader = vim.api.nvim_replace_termcodes('<BS>', false, false, true)

vim.keymap.set('n', "<leader>'", '"+')

vim.keymap.set('i', 'jk', '<ESC>');
vim.keymap.set('n', '<C-j>', '2<C-e>')
vim.keymap.set('n', '<C-k>', '2<C-y>')

-- vim.keymap.set('n', 'j', 'gj')
-- vim.keymap.set('n', 'k', 'gk')
-- vim.keymap.set('n', '0', 'g0')
-- vim.keymap.set('n', '$', 'g$')

vim.keymap.set('n', 'sj', '<C-W>j')
vim.keymap.set('n', 'sk', '<C-W>k')
vim.keymap.set('n', 'sh', '<C-W>h')
vim.keymap.set('n', 'sl', '<C-W>l')
vim.keymap.set('n', 'SK', ':res +5<CR>')
vim.keymap.set('n', 'SJ', ':res -5<CR>')
vim.keymap.set('n', 'SL', ':vertical resize +5<CR>')
vim.keymap.set('n', 'SH', ':vertical resize -5<CR>')

vim.keymap.set('n', 'tl', ':tabnext<CR>')
vim.keymap.set('n', 'th', ':tabprev<CR>')
vim.keymap.set('n', 'tt', ':tabnew<space>')
vim.keymap.set('n', 'td', ':tabclose<CR>')
vim.keymap.set('n', '<C-t>h', ':tabm -1<CR>')
vim.keymap.set('n', '<C-t>l', ':tabm +1<CR>')
vim.keymap.set('n', 't]', '<c-w>]<c-w>T<CR>' )

vim.keymap.set('n', '<leader>]', ':next<CR>')
vim.keymap.set('n', '<leader>[', ':prev<CR>')

vim.keymap.set('n', '<F5>', function()
    vim.opt.background = vim.opt.background._value == 'dark' and 'light' or 'dark'
end)

vim.keymap.set('n', '<leader>N', function() vim.opt.number = not vim.opt.number._value end)
vim.keymap.set('n', '<leader>n', function() vim.opt.relativenumber = not vim.opt.relativenumber._value end)
vim.keymap.set('n', '<leader>S', function() vim.opt.spell = not vim.opt.spell._value end)
vim.keymap.set('n', '<leader>h', function() vim.opt.hlsearch = not vim.opt.hlsearch._value end)

vim.keymap.set('n', 'ff',  ':FZF<CR>')
vim.keymap.set('n', 'fgf', ':GFiles<CR>')
vim.keymap.set('n', 'fsf', ':GFiles?<CR>')
vim.keymap.set('n', 'fbf', ':Buffers<CR>')
vim.keymap.set('n', 'faf', ':Ag<CR>')

vim.keymap.set('n', '<leader>ev', ':tabnew $MYVIMRC<CR>')
vim.keymap.set('n', '<leader>sv', ':source $MYVIMRC<CR>')
--------------------------------------------------


--- Theme ----------------------------------------
vim.opt.background = vim.env.THEME
vim.g.airline_theme = 'zenburn'
vim.g.airline_powerline_fonts = 1
vim.g.gruvbox_contrast_dark  = 'soft'
vim.g.gruvbox_contrast_light = 'hard'
vim.cmd.colorscheme("gruvbox")
--------------------------------------------------

require("treesitter")
