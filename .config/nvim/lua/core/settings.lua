local vim = vim
vim.g.maplocalleader = " "
vim.g.mapleader = " "

vim.opt.termguicolors = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"

vim.opt.ignorecase = true
vim.opt.smartcase = true

--- Set highlight on search
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.splitright = true
vim.o.splitbelow = true

-- Keep signcolumn on by default
vim.wo.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.smartindent = true
vim.o.autoindent = true

-- Tab width
vim.opt.tabstop = 2

-- Amount of characters Neovim will
-- use to indent a line
vim.opt.shiftwidth = 2

-- Controls whether or not Neovim
-- should transform a Tab character
-- to spaces. The default value is false.
vim.opt.expandtab = true
vim.opt.expandtab = true

-- Windows Separators
vim.cmd([[:filetype plugin on]])
vim.cmd([[:highlight WinSeparator guibg=None]])
vim.cmd([[:highlight WinSeparator guifg=#aaaaaa]])
vim.cmd([[:set laststatus=3]])
