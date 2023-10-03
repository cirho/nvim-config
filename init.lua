vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- disable providers for faster startup
vim.g.loaded_python3_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

require('globals')
require('options')
require('ft')
require('diagnostics')

vim.loader.enable()
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.opt.rtp:prepend(lazypath)

local use_conf = function(repo, deps)
  local name = repo:match('/([%w-]*)'):gsub('.*-', '')
  local deps = deps or {}

  return {
    repo,
    dependencies = deps,
    config = function()
      require('plugins.' .. name);
    end
  }
end

require("lazy").setup({
  'neovim/nvim-lspconfig',
  'nvim-lua/lsp-status.nvim',
  'nvim-treesitter/nvim-treesitter',
  use_conf('L3MON4D3/luasnip'),
  use_conf('hrsh7th/nvim-cmp', {
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-nvim-lua',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'ray-x/cmp-treesitter',
    'saadparwaiz1/cmp_luasnip',
    'L3MON4D3/luasnip',
  }),
  'nvim-lua/plenary.nvim',
  use_conf('nvim-telescope/telescope.nvim'),
  {
    'airblade/vim-rooter', config = function() vim.g.rooter_patterns = { ".git" } end
  },
  use_conf('lewis6991/gitsigns.nvim'),
  use_conf('b3nj5m1n/kommentary'),
  'kyazdani42/nvim-web-devicons',
  use_conf 'feline-nvim/feline.nvim',
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = { 'nvim-treesitter' },
    config = function() require('plugins.treesitter') end,
  },{
    'sainnhe/sonokai', config = function()
      vim.g.sonokai_style = 'shusia'
      vim.cmd [[ colorscheme sonokai ]]
    end
  }},{
  change_detection = {
    enabled = false,
    notify = false,
  },
})
