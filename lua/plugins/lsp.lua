local lspconfig = require('lspconfig')
local tele = require('telescope.builtin')

local on_attach = function(client, bufnr)
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

  map('n', '<leader>rn', vim.lsp.buf.rename)

  map('n', 'K', vim.lsp.buf.hover)
  map('n', '<c-s>', vim.lsp.buf.signature_help)

  map('n', '<leader>a', vim.lsp.buf.code_action)
  map('v', '<leader>a', vim.lsp.buf.range_code_action)

  map('n', '<leader>rf', tele.lsp_references)

  if client.server_capabilities.documentHighlightProvider then
    local group = vim.api.nvim_create_augroup('lsp_document_highlight', { clear = true })
    vim.api.nvim_create_autocmd("CursorHold", {
      buffer = 0,
      group = group,
      callback = vim.lsp.buf.document_highlight
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      buffer = 0,
      group = group,
      callback = vim.lsp.buf.clear_references
    })
  end
end

local servers = {}

-- rust
servers.rust_analyzer = {
  settings = {
    flags = {
      debounce_text_changes = false,
    }, ['rust-analyzer'] = {
      assist = {
        importGranularity = 'module',
        importPrefix = 'by_self',
      },
      cargo = {
        loadOutDirsFromCheck = true,
      },
      procMacro = {
        enable = true,
      },
    },
  },
}

-- c/cpp
servers.clangd = {
  cmd = {
    'clangd',
    '--background-index',
    '--clang-tidy',
    '--header-insertion=iwyu',
  },
}

-- latex
servers.texlab = {
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
}

servers.typst_lsp= {}
servers.pylsp = {}

-- -- lua
-- servers.sumneko_lua = {
--   cmd = { 'lua-language-server' },
--   settings = {
--     Lua = {
--       runtime = {
--         version = 'LuaJIT',
--         path = vim.split(package.path, ';'),
--       },
--       diagnostics = {
--         globals = {'vim'},
--       },
--       telemetry = {
--         enable = false,
--       },
--     }
--   }
-- }

local capabilities = require('cmp_nvim_lsp').default_capabilities()

for name, server in pairs(servers) do
  lspconfig[name].setup(vim.tbl_extend('keep', server, {
    on_attach = on_attach,
    capabilities = capabilities
  }))
end
