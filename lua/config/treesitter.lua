local treesitter = require('nvim-treesitter.configs')

treesitter.setup {
  ensure_installed = "maintained", 
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
