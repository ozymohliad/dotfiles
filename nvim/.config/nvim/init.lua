-- Basic options
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.o.breakindent = true
vim.o.hlsearch = false
vim.o.completeopt = 'menuone,noselect'
vim.o.ignorecase = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.smartcase = true
vim.o.timeout = true
vim.o.timeoutlen = 200
vim.o.undofile = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.cursorline = true
vim.opt.scrolloff = 5
vim.opt.updatetime = 500
vim.opt.list = true
vim.opt.listchars = 'tab:<->,trail:-,nbsp:+,multispace:-,lead:\\x20'

-- Mappings
local mapping = require("mappings")
mapping.jk_esc()
mapping.non_destructive_paste()
mapping.center_after_jump()
mapping.scroll(2)
mapping.split()
mapping.tab()
mapping.diagnostics()
mapping.toggles()

vim.cmd([[command! W w | !cd $(dirname %) && test -f Makefile && make]])

-- Plugins
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)
require('lazy').setup("plugins")
