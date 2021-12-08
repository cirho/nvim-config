require('packer').startup(function(use)
  local use_conf = function(repo, deps) 
    local name = repo:match('/([%w-]*)'):gsub('.*-', '')
    local deps = deps or {}
    use { repo, requires = deps, config = string.format("require('plugins.%s')", name) }
  end

  use 'wbthomason/packer.nvim'

  use 'simrat39/rust-tools.nvim'
  use 'neovim/nvim-lspconfig'
  use 'nvim-lua/lsp-status.nvim'

  use_conf 'L3MON4D3/luasnip'
  use_conf 'nvim-treesitter/nvim-treesitter'

  use_conf('hrsh7th/nvim-cmp',{
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-nvim-lua',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'ray-x/cmp-treesitter',
    'saadparwaiz1/cmp_luasnip',
  })

  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use_conf 'nvim-telescope/telescope.nvim'

  use 'airblade/vim-rooter'
  use { 'blackCauldron7/surround.nvim', config = I(require('surround').setup({ mapping_style = "sandwitch" })) }
  use_conf 'lewis6991/gitsigns.nvim'
  use_conf 'b3nj5m1n/kommentary'

  use {
    'sainnhe/sonokai', config = function()
      vim.g.sonokai_style = 'shusia'
      vim.cmd [[ colorscheme sonokai ]]
    end
  }
  use 'kyazdani42/nvim-web-devicons'
  use_conf 'glepnir/galaxyline.nvim'
end)
