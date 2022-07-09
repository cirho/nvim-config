local lspconfig = require('lspconfig')

local on_attach = function(client, bufnr)
  local opts = { silent = true, noremap = true, nowait = true }

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

  map_lsp('n', '<leader>rn', 'buf.rename')

  map_lsp('n', 'K', 'buf.hover')
  map_lsp('n', '<c-s>', 'buf.signature_help')

  map_lsp('v', '<leader>a', 'buf.range_code_action')

  map_telescope('n', '<leader>a', 'lsp_code_actions')
  map_telescope('n', '<leader>rf', 'lsp_references')

  if client.resolved_capabilities.document_highlight then
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

local capabilities = require('cmp_nvim_lsp').update_capabilities(require('lsp-status').capabilities)
local servers = {}

-- rust
require('rust-tools').setup({
  tools = {
    hover_with_action = false,
    hover_actions = {
      border = 'none'
    },
    inlay_hints = {
      show_parameter_hints = false,
      other_hints_prefix = '> ',
    },
  },
  server = {
    on_attach = on_attach,
    capabilities = capabilities,
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
})

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

-- lua
servers.sumneko_lua = {
  cmd = { 'lua-language-server' },
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        globals = {'vim'},
      },
      telemetry = {
        enable = false,
      },
    }
  }
}

for name, server in pairs(servers) do
  lspconfig[name].setup(vim.tbl_extend('keep', server, {
    on_attach = on_attach,
    capabilities = capabilities
  }))
end
