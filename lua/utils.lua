local M = {}

function M.map(f, t, m, opts)
  local m = m or 'n'
  local opts = opts or { silent = true, noremap = true, nowait = true }

  vim.api.nvim_set_keymap(m, f, t, opts)
end

function M.is_buffer_empty()
  return vim.fn.empty(vim.fn.expand('%:t')) == 1
end

function M.has_width_gt(cols)
  return vim.fn.winwidth(0) / 2 > cols
end

function M.change_indent(spaces)
  vim.bo.shiftwidth = spaces
  vim.bo.softtabstop = spaces
  vim.bo.tabstop = spaces
end

function M.hard_tabs()
  vim.bo.expandtab = false
end

return M
