return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp'
  },
  config = function()
    local lspconfig = require('lspconfig')
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
        on_attach = require('lo.lsp').custom_attach,
        capabilities = capabilities
      }))
    end

    for server, config in pairs(servers) do
      setup_server(server, config)
    end
  end
}
