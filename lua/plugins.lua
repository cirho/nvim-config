vim.cmd [[packadd packer.nvim]]

vim.api.nvim_exec([[
  augroup Packer
    autocmd!
    autocmd BufWritePost plugins.lua PackerCompile
  augroup end
]], false)

return require('packer').startup(function()
  use {'wbthomason/packer.nvim', opt = true}
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-compe'
  use 'hrsh7th/vim-vsnip'
  use 'nvim-lua/lsp-status.nvim'
  use 'nvim-lua/lsp_extensions.nvim'
  use 'lewis6991/gitsigns.nvim'
  use 'airblade/vim-rooter'
  use 'b3nj5m1n/kommentary'
  use { 'vlime/vlime', opt = true }

  --use 'blackCauldron7/surround.nvim'
  use 'tpope/vim-surround'

  use {'glepnir/galaxyline.nvim',  requires = {'kyazdani42/nvim-web-devicons', opt = true}}

  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use { 'sainnhe/sonokai', config = function() vim.cmd [[ colorscheme sonokai ]] end }
 end)
