local map = require('lo.utils').map

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

-- map(']d', vim.diagnostic.goto_next)
-- map('[d', vim.diagnostic.goto_prev)
map('<leader>e', vim.diagnostic.open_float)
