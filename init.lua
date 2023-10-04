vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- disable providers for faster startup
vim.g.loaded_python3_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

vim.g.asmsyntax = 'nasm'

require('lo.debug')
require('lo.options')
require('lo.diagnostics')

vim.loader.enable()
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("lo.plugins", {
  change_detection = {
    enabled = false,
    notify = false,
  },
})
