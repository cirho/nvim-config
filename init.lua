vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.do_filetype_lua = 1
vim.g.did_load_filetypes = 0

require('globals')
require('options')
require('ft')
require('diagnostics')
require('plugins')
