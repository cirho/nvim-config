return {
  {
    'airblade/vim-rooter',
    config = function() vim.g.rooter_patterns = { ".git" } end
  }, {
    'nvim-lua/plenary.nvim',
  }, {
    'sainnhe/sonokai',
    config = function()
      vim.g.sonokai_style = 'shusia'
      vim.cmd [[ colorscheme sonokai ]]
    end
  }
}
