local cmd = vim.cmd 

local lsp_status = require('lsp-status')
local lspconfig = require('lspconfig')
local capabilities = lsp_status.capabilities

lsp_status.config{
  status_symbol = ' lsp:'
}

lsp_status.register_progress()

capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}

-- for diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = false,
  }
)

local on_attach = function(client, bufnr) 
  local opts = { noremap = true, silent = true, nowait = true}
  local function keymap(m, f, t) vim.api.nvim_buf_set_keymap(bufnr, m, f, t, opts) end
  keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
  keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
  keymap('n', '<leader>d', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
  keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
  keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')

  keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>')

  keymap('n', 'g[', '<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>')
  keymap('n', 'g]', '<cmd>lua vim.lsp.diagnostic.goto_next()<cr>')

  keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
  keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>')

  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
    augroup lsp_document_highlight
      autocmd! * <buffer>
      autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    augroup END
    ]], false)
  end

  if client.resolved_capabilities.document_formatting then
    vim.api.nvim_exec([[
    augroup format_on_save
      autocmd! * <buffer>
      autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting()
    augroup END
    ]], false)
  end
end

-- show inlay hints and other fun stuff
cmd [[ autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost * lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "Comment", enabled = {"TypeHint", "ChainingHint" } } ]] 

-- rust
lspconfig.rust_analyzer.setup{ 
  on_attach = on_attach, 
  cmd = { "/home/cirho/data/cargo/bin/rust-analyzer" },
  capabilities = capabilities,
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = {
        enable = true,
      },
      assist = {
        importMergeBehaviour = "full",
        importPrefix = "by_crate",
      },
    },
  },
}

lspconfig.clangd.setup{
  cmd = {
    "clangd",
    "--background-index",
    "--suggest-missing-includes",
    "--clang-tidy",
    "--header-insertion=iwyu",
  },
  on_attach = on_attach,
  capabilities = capabilities,
}
