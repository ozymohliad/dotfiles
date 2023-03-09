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
vim.opt.expandtab = true;
vim.opt.shiftwidth = 4;

-- Mappings
local mapping = require("mappings")
mapping.scroll(2)
mapping.split()
mapping.tab()
mapping.diagnostics()
mapping.toggles()

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
