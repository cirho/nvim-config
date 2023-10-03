local langs = {"python", "lua", "json", "regex", "rust", "toml", "bash", "cpp", "c", "lua", "fish", "ledger" }

return {
  'nvim-treesitter/nvim-treesitter',
  build = ":TSUpdate",
  ft = langs,
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  config = function()
    vim.opt.foldmethod = 'expr'
    vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

    require('nvim-treesitter.configs').setup({
      ensure_installed = langs,
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
    })
  end
}
