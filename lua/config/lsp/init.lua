local lsp_status = require('lsp-status')
local lspconfig = require('lspconfig')
local capabilities = lsp_status.capabilities

lsp_status.config{
  status_symbol = ' lsp:'
}

lsp_status.register_progress()

capabilities.textDocument.completion.completionItem.snippetSupport = true

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
  keymap('n', 'gD', '<CMD>lua vim.lsp.buf.declaration()<CR>')
  keymap('n', 'gd', '<CMD>lua vim.lsp.buf.definition()<CR>')
  keymap('n', 'K', '<CMD>lua vim.lsp.buf.hover()<CR>')
  keymap('n', 'gi', '<CMD>lua vim.lsp.buf.implementation()<CR>')
  keymap('n', 'gr', '<CMD>lua vim.lsp.buf.references()<CR>')
  keymap('n', 'rn', '<CMD>lua vim.lsp.buf.rename()<CR>')
  keymap('n', 'W', '<CMD>lua vim.lsp.diagnostic.goto_prev()<CR>')
  keymap('n', 'E', '<CMD>lua vim.lsp.diagnostic.goto_next()<CR>')

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
vim.cmd [[autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost * lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "Comment", enabled = {"TypeHint", "ChainingHint" } }]] 

-- rust
lspconfig.rust_analyzer.setup{ 
  on_attach = on_attach, 
  cmd = { "/home/cirho/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin/rust-analyzer" },
  capabilities = capabilities,
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = {
        enable = false,
      },
      assist = {
        importMergeBehaviour = "full",
        importPrefix = "by_crate",
      },
    },
  },
}

