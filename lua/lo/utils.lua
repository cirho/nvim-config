local M = {}

M.map = function(f, t, m, opts)
  local m = m or 'n'
  local opts = opts or { silent = true, noremap = true, nowait = true }

  vim.api.nvim_set_keymap(m, f, t, opts)
end

M.is_buffer_empty = function()
  return vim.fn.empty(vim.fn.expand('%:t')) == 1
end

M.has_width_gt = function(cols)
  return vim.fn.winwidth(0) / 2 > cols
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
