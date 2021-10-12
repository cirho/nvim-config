vim.cmd('packadd packer.nvim')

-- remember to run :PackerCompile after making any changes !!!

local get_config = function(name)
  require('plugins.' .. name)
end

require('packer').startup(function()
  use { 'wbthomason/packer.nvim', opt = true }

  use 'neovim/nvim-lspconfig'
  use 'nvim-lua/lsp-status.nvim'
  use 'nvim-lua/lsp_extensions.nvim'

  use 'airblade/vim-rooter'
  use { 'blackCauldron7/surround.nvim', config = function() require('surround').setup({ mapping_style = "sandwitch" }) end }
  use { 'lewis6991/gitsigns.nvim', config = get_config('gitsigns') }
  use { 'b3nj5m1n/kommentary', config = get_config('kommentary') }

  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-vsnip',
      { 'hrsh7th/vim-vsnip', config = get_config('vsnip') },
      'ray-x/cmp-treesitter'
    },
    config = get_config('cmp')
  }
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', config = get_config('treesitter') }

  use {
    'sainnhe/sonokai', config = function()
      vim.g.sonokai_style = 'shusia'
      vim.cmd [[ colorscheme sonokai ]]
    end
  }
  use {
    'glepnir/galaxyline.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = get_config('galaxyline')
  }
  use {
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim' },
    config = get_config('telescope')
  }

  use { 'lervag/vimtex', ft = { 'tex' }, config = get_config('vimtex') }
end)

require('plugins.lsp')
