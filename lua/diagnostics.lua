local map = require('utils').map

vim.diagnostic.config({
  underline = true,
  virtual_text = {
    severity = nil,
    source = "if_many",
    format = nil,
  },
  signs = true,

  float = {
    show_header = true,
  },

  severity_sort = true,
  update_in_insert = false,
})

map(']d', '<cmd> lua vim.diagnostic.goto_next()<cr>')
map('[d', '<cmd> lua vim.diagnostic.goto_prev()<cr>')
map('<leader>e', '<cmd> lua vim.diagnostic.open_float()<cr>')
