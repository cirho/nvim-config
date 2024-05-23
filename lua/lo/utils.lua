local M = {}

M.map = function(f, t, m, opts)
  local m = m or 'n'
  local opts = opts or { silent = true, noremap = true, nowait = true }

  vim.keymap.set(m, f, t, opts)
end

M.change_indent = function(spaces)
  vim.opt_local.shiftwidth = spaces
  vim.opt_local.softtabstop = spaces
  vim.opt_local.tabstop = spaces
end

M.soft_tabs = function()
  vim.opt_local.expandtab = true
  vim.opt_local.listchars = vim.opt_local.listchars + { tab = '<->', leadmultispace = ' '}
end

M.hard_tabs = function()
  vim.opt_local.expandtab = false
  vim.opt_local.listchars = vim.opt_local.listchars + { tab = '  ' } - { 'leadmultispace' }
end

return M
