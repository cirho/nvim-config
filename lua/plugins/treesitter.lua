local opt = vim.opt

local treesitter = require('nvim-treesitter.configs')

treesitter.setup {
  ensure_installed = {"python", "lua", "json", "regex", "rust", "toml", "bash", "cpp", "c", "lua", "fish", "ledger" },
  highlight = {
    enable = true,
    use_languagetree = true,
    disable = { "rust" },
  },
  indent = {
    enable = false,
  },
  incremental_selection = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
  },
}

opt.foldmethod = 'expr'
opt.foldexpr = 'nvim_treesitter#foldexpr()'
