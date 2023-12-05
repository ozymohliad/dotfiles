local Toggles = require("toggles")

local M = {}

function M.jk_esc()
    vim.keymap.set('i', 'jk', '<ESC>');
end

function M.non_destructive_paste()
    vim.keymap.set('v', 'p', '"_dP');
end

function M.center_after_jump()
    vim.keymap.set('n', '<C-d>', '<C-d>zz');
    vim.keymap.set('n', '<C-u>', '<C-u>zz');
    vim.keymap.set('n', 'n', 'nzz');
    vim.keymap.set('n', 'N', 'Nzz');
end

function M.scroll(speed)
    speed = tonumber(speed) or ""
    vim.keymap.set('n', '<C-j>', speed .. '<C-e>')
    vim.keymap.set('n', '<C-k>', speed .. '<C-y>')
end

function M.split()
    vim.keymap.set('n', 'ss', ':new<CR>')
    vim.keymap.set('n', 'sv', ':vne<CR>')
    vim.keymap.set('n', 'sq', '<C-W>c')
    vim.keymap.set('n', 'so', '<C-W>o')

    vim.keymap.set('n', 'sj', '<C-W>j')
    vim.keymap.set('n', 'sk', '<C-W>k')
    vim.keymap.set('n', 'sh', '<C-W>h')
    vim.keymap.set('n', 'sl', '<C-W>l')

    vim.keymap.set('n', 's=', ':res +5<CR>')
    vim.keymap.set('n', 's-', ':res -5<CR>')
    vim.keymap.set('n', 's.', ':vertical resize +5<CR>')
    vim.keymap.set('n', 's,', ':vertical resize -5<CR>')
end

function M.tab()
    vim.keymap.set('n', 'tl', ':tabnext<CR>')
    vim.keymap.set('n', 'th', ':tabprev<CR>')
    vim.keymap.set('n', 'tt', ':tabnew<space>')
    vim.keymap.set('n', 'td', ':tabclose<CR>')
    vim.keymap.set('n', 'Th', ':tabm -1<CR>')
    vim.keymap.set('n', 'Tl', ':tabm +1<CR>')
    vim.keymap.set('n', 't]', '<c-w>]<c-w>T' )
end

function M.diagnostics()
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
    vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
end

function M.toggles()
    vim.keymap.set('n', '<leader>tn', Toggles.relativenumber, { desc = "Toggle relative [n]umbers" })
    vim.keymap.set('n', '<leader>tw', Toggles.dash_keyword, { desc = "Toggle '-' as part of a [w]ord" })
    vim.keymap.set('n', '<leader>tg', Toggles.visual_line, { desc = "Toggle between logical and visual lines" })
    vim.keymap.set('n', '<leader>tc', Toggles.clipboard, { desc = "Toggle using system [c]lipboard" })
    vim.keymap.set('n', '<leader>ts', Toggles.spell, { desc = "Toggle [s]pelling" })
    vim.keymap.set('n', '<leader>th', Toggles.hlsearch, { desc = "Toggle search [h]ighlighting" })
    vim.keymap.set('n', '<leader>ty', Toggles.highlight_yank, { desc = "Toggle [y]ank highlighting" })
    vim.keymap.set('n', '<leader>td', Toggles.diagnostics, { desc = "Toggle [d]iagnostics" })
    vim.keymap.set('n', '<leader>tH', Toggles.definition_highlight, { desc = "Toggle definition [H]ighlighting" })
    vim.keymap.set('n', '<leader>tC', Toggles.context, { desc = "Toggle Treesitter [C]ontext" })
    vim.keymap.set('n', '<F5>', Toggles.background, { desc = "Toggle between dark/light theme" })
end


return M
