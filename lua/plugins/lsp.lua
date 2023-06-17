local lspconfig = require('lspconfig')
local tele = require('telescope.builtin')

local on_attach = function(client, bufnr)
  local lsp = vim.lsp.buf
  local opts = { silent = true, noremap = true, nowait = true, buffer = bufnr }

  local map = function(mode, key, fn)
    vim.keymap.set(mode, key, fn, opts)
  end

  map('n', 'gD', lsp.declaration)
  map('n', 'gd', lsp.definition)
  map('n', 'gi', lsp.implementation)
  map('n', 'gr', lsp.references)
  map('n', '<leader>f', function() lsp.format({ async = true }) end )
  map('n', '<leader>d', lsp.type_definition)

  map('n', '<leader>rn', lsp.rename)

  map('n', 'K', lsp.hover)
  map('n', '<c-s>', lsp.signature_help)

  map('n', '<leader>a', lsp.code_action)
  map('v', '<leader>a', lsp.range_code_action)

  map('n', '<leader>rf', tele.lsp_references)

  if client.server_capabilities.documentHighlightProvider then
    local group = vim.api.nvim_create_augroup('lsp_document_highlight', { clear = true })
    vim.api.nvim_create_autocmd("CursorHold", { buffer = 0, group = group, callback = lsp.document_highlight })
    vim.api.nvim_create_autocmd("CursorMoved", { buffer = 0, group = group, callback = lsp.clear_references })
  end
end

local servers = {
  rust_analyzer = {
    settings = {
      flags = {
        debounce_text_changes = false,
      }, ['rust-analyzer'] = {
      },
    },
  },
  clangd = {
    cmd = { 'clangd', '--background-index', '--clang-tidy', '--header-insertion=iwyu', },
  },
  texlab = {
    cmd_env = {
      TEXMFCONFIG = vim.env.XDG_DATA_HOME .. "/texlive/texmf-config",
      TEXMFVAR = vim.env.XDG_DATA_HOME .."/texlive/texmf-var"
    },
    settings = {
      texlab = {
        build = {
          onSave = true,
        }
      }
    }
  },
  pylsp = true,
  typst_lsp = true,
}

local capabilities = require('cmp_nvim_lsp').default_capabilities()

local setup_server = function(server, config)
  local exec = server:gsub("_", "-")
  if not config or vim.fn.executable(exec) == 0 then
    return
  end

  if type(config) ~= "table" then
    config = {}
  end

  lspconfig[server].setup(vim.tbl_extend('keep', config, {
    on_attach = on_attach,
    capabilities = capabilities
  }))
end

for server, config in pairs(servers) do
  setup_server(server, config)
end
