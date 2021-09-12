local opt = vim.opt

local treesitter = require('nvim-treesitter.configs')

treesitter.setup {
  ensure_installed = {"html", "python", "lua", "json", "regex", "rust", "toml", "bash", "css", "cpp", "c", "java" },
  highlight = {
    enable = true,
    use_languagetree = true,
    disable = { "rust" }, 
  },
  indent = {
    enable = false,
    disable = { "rust" }
  },
  rainbow = {
    enable = true,
  }
}

opt.foldmethod = 'expr'
opt.foldexpr = 'nvim_treesitter#foldexpr()'
