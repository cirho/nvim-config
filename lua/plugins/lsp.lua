local cmp = require('cmp')
local cmp_nvim_lsp = require('cmp_nvim_lsp')
local lspconfig = require('lspconfig')
local lsp_status = require('lsp-status')
local lsp_extensions = require('lsp_extensions')

local M = {}

local capabilities = cmp_nvim_lsp.update_capabilities(lsp_status.capabilities)

local on_attach = function(client, bufnr) 
  local opts = { noremap = true, silent = true, nowait = true }
  local map = function(m, f, t) vim.api.nvim_buf_set_keymap(bufnr, m, f, t, opts) end

  map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
  map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
  map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
  map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')
  map('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<cr>')
  map('n', '<leader>d', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
  map('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>')

  map('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>')

  map('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>')
  map('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<cr>')

  map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
  map('n', '<c-s>', '<cmd>lua vim.lsp.buf.signature_help()<cr>')

  map('n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<cr>')
  map('v', '<leader>a', '<cmd>lua vim.lsp.buf.range_code_action()<cr>')

  map('n', '<leader>q', '<cmd>lua require("telescope.builtin").lsp_workspace_diagnostics()<cr>')
  map('n', '<leader>rf', '<cmd>lua require("telescope.builtin").lsp_references()<cr>')

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
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostic, {
        severity_sort = true
    }
)

-- show inlay 
M.inlay_hints = function()
  lsp_extensions.inlay_hints({ 
    prefix = '',
    highlight = "Comment",
    enabled = { "TypeHint", "ChainingHint" } 
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

-- c/cpp
servers.clangd = {
  cmd = {
    "clangd",
    "--background-index",
    "--suggest-missing-includes",
    "--clang-tidy",
    "--header-insertion=iwyu",
  },
}

for name, server in pairs(servers) do
  lspconfig[name].setup(vim.tbl_extend('keep', server, {
    on_attach = on_attach,
    capabilities = capabilities
  }))
end

return M
