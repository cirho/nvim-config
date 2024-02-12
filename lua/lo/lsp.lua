local custom_attach = function(client, bufnr)
  local opts = { silent = true, noremap = true, nowait = true, buffer = bufnr }

  local map = function(mode, key, fn)
    vim.keymap.set(mode, key, fn, opts)
  end

  map('n', 'gD', vim.lsp.buf.declaration)
  map('n', 'gd', vim.lsp.buf.definition)
  map('n', 'gi', vim.lsp.buf.implementation)
  map('n', 'gr', vim.lsp.buf.references)
  map('n', '<leader>f', function() vim.lsp.buf.format({ async = true }) end )
  map('n', '<leader>d', vim.lsp.buf.type_definition)

  map('n', '<leader>r', vim.lsp.buf.rename)

  map('n', 'K', vim.lsp.buf.hover)
  map('n', '<c-s>', vim.lsp.buf.signature_help)

  map('n', '<leader>a', vim.lsp.buf.code_action)
  map('v', '<leader>a', vim.lsp.buf.range_code_action)

  if client.server_capabilities.documentHighlightProvider then
    local group = vim.api.nvim_create_augroup('lsp_document_highlight', { clear = true })
    vim.api.nvim_create_autocmd("CursorHold", { buffer = 0, group = group, callback = vim.lsp.buf.document_highlight })
    vim.api.nvim_create_autocmd("CursorMoved", { buffer = 0, group = group, callback = vim.lsp.buf.clear_references })
  end
end

return {
  custom_attach = custom_attach
}
