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

local map = function(key, fn)
  vim.keymap.set('n', key, fn, { silent = true, noremap = true, nowait = true })
end

map(']d', vim.diagnostic.goto_next)
map('[d', vim.diagnostic.goto_prev)
map('<leader>e', vim.diagnostic.open_float)
map('<leader>q', vim.diagnostic.setqflist)
