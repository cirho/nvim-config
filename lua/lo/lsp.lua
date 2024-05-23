local custom_attach = function(client, bufnr) end

local global_attach = function()
  local opts = { silent = true, noremap = true, nowait = true }

  local map = function(mode, key, fn)
    vim.keymap.set(mode, key, fn, opts)
  end

  map('n', 'gD', vim.lsp.buf.declaration)
  map('n', 'gd', vim.lsp.buf.definition)
  map('n', 'gi', vim.lsp.buf.implementation)
  map('n', 'gr', vim.lsp.buf.references)
  map('n', 'gy', vim.lsp.buf.type_definition)
  map('n', '<leader>=', function() vim.lsp.buf.format({ async = true }) end)
  map('v', '<leader>=', function() vim.lsp.buf.format({ async = true }) end)

  map('n', '<leader>r', vim.lsp.buf.rename)
  map('n', '<leader>k', vim.lsp.buf.hover)

  map('n', '<leader>a', vim.lsp.buf.code_action)
  map('v', '<leader>a', vim.lsp.buf.code_action)
  map('n', '<leader>i', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end)

end

return {
  custom_attach = custom_attach,
  global_attach = global_attach,
}
