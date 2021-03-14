local M = {}

function M.keymap(f, t, m, opts)
  local m = m or 'n'
  local opts = opts or { silent = true, noremap = true, nowait = true }

  vim.api.nvim_set_keymap(m, f, t, opts)
end

function M.opt(o, v, scopes)
  scopes = scopes or {vim.o}
  for _, s in ipairs(scopes) do s[o] = v end
end

function M.is_buffer_empty()
  return vim.fn.empty(vim.fn.expand('%:t')) == 1
end

function M.has_width_gt(cols)
  return vim.fn.winwidth(0) / 2 > cols
end

return M
