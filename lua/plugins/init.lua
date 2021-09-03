vim.cmd [[packadd packer.nvim]]

-- remember to run :PackerCompile after making any changes !!!

local function get_config(name)
  require('plugins.' .. name)
end

require('packer').startup(function()
  use { 'wbthomason/packer.nvim', opt = true }

  use { 'hrsh7th/vim-vsnip', config = get_config('vsnip') }

  use 'neovim/nvim-lspconfig'
  use 'nvim-lua/lsp-status.nvim'
  use 'nvim-lua/lsp_extensions.nvim' 

  use { 'hrsh7th/nvim-compe', config= get_config('completion') }

  use { 'sainnhe/sonokai', config = function() vim.cmd [[ colorscheme sonokai ]] end }
  use { 'glepnir/galaxyline.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true},
        config = get_config('galaxyline') }


  use { 'lewis6991/gitsigns.nvim', config = get_config('gitsigns') }
  use 'airblade/vim-rooter'

  use { 'b3nj5m1n/kommentary', config = get_config('kommentary') }

  use 'tpope/vim-surround'


  use { 'vlime/vlime', opt = true }
  use { 'lervag/vimtex', ft = { 'tex' }, config = get_config('vimtex') }

  use { 'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
        config = get_config('telescope') }

  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', config = get_config('treesitter') }
end)

require('plugins.lsp')
