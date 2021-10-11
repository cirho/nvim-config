local cmp = require('cmp')
local cmp_nvim_lsp = require('cmp_nvim_lsp')
local lspconfig = require('lspconfig')
local lsp_status = require('lsp-status')
local lsp_extensions = require('lsp_extensions')

local M = {}

local capabilities = cmp_nvim_lsp.update_capabilities(lsp_status.capabilities)

local on_attach = function(client, bufnr)
  local opts = opts or { silent = true, noremap = true, nowait = true }

  local map_lsp = function(mode, key, fn)
    local lsp_fn = string.format('<cmd> lua vim.lsp.%s()<cr>', fn)
    vim.api.nvim_buf_set_keymap(bufnr, mode, key, lsp_fn, opts)
  end
  local map_telescope = function(mode, key, fn)
    local tele_fn = string.format('<cmd>lua require("telescope.builtin").%s()<cr>', fn)
    vim.api.nvim_buf_set_keymap(bufnr, mode, key, tele_fn, opts)
  end

  map_lsp('n', 'gD', 'buf.declaration')
  map_lsp('n', 'gd', 'buf.definition')
  map_lsp('n', 'gi', 'buf.implementation')
  map_lsp('n', 'gr', 'buf.references')
  map_lsp('n', '<leader>f', 'buf.formatting')
  map_lsp('n', '<leader>d', 'buf.type_definition')
  map_lsp('n', '<leader>e', 'diagnostic.show_line_diagnostics')

  map_lsp('n', '<leader>rn', 'buf.rename')

  map_lsp('n', '[d', 'diagnostic.goto_prev')
  map_lsp('n', ']d', 'diagnostic.goto_next')

  map_lsp('n', 'K', 'buf.hover')
  map_lsp('n', '<c-s>', 'buf.signature_help')

  map_lsp('v', '<leader>a', 'buf.range_code_action')

  map_telescope('n', '<leader>a', 'lsp_code_actions')
  map_telescope('n', '<leader>q', 'lsp_workspace_diagnostics')
  map_telescope('n', '<leader>rf', 'lsp_references')

  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
end

-- display error before warning or hint in signcolumn
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        severity_sort = true
    }
)

-- show inlay
M.inlay_hints = function()
  lsp_extensions.inlay_hints({
    prefix = '',
    highlight = 'Comment',
    enabled = { 'TypeHint', 'ChainingHint' }
  })
end

vim.cmd('autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost * lua require("plugins.lsp").inlay_hints()')

-- statusline provider
local lsp_symbol = ''

lsp_status.config{
  status_symbol = lsp_symbol,
  diagnostics = false
}

lsp_status.register_progress()

M.status = function()
  if not vim.tbl_isempty(vim.lsp.buf_get_clients()) then
    local output = lsp_status.status()
    if output == lsp_symbol .. ' ' then return output .. 'ready ' end
    return output
  end
  return ''
end

local servers = {}

-- rust
servers.rust_analyzer = {
  settings = {
    ['rust-analyzer'] = {
      checkOnSave = {
        enable = true,
      },
      assist = {
        importMergeBehaviour = 'full',
        importPrefix = 'by_crate',
      },
    },
  },
}

-- c/cpp
servers.clangd = {
  cmd = {
    'clangd',
    '--background-index',
    '--suggest-missing-includes',
    '--clang-tidy',
    '--header-insertion=iwyu',
  },
}

for name, server in pairs(servers) do
  lspconfig[name].setup(vim.tbl_extend('keep', server, {
    on_attach = on_attach,
    capabilities = capabilities
  }))
end

return M
