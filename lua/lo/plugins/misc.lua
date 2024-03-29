return {
  {
    'airblade/vim-rooter',
    config = function() vim.g.rooter_patterns = { ".git" } end
  }, {
    'nvim-lua/plenary.nvim',
  }, {
    'ellisonleao/gruvbox.nvim',
    config = function()
      require("gruvbox").setup({
        terminal_colors = true,
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings = false,
          emphasis = false,
          comments = false,
          operators = false,
          folds = false,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true,
        contrast = "",
        palette_overrides = {
          grey = '#ffffff',
          dark0 = '#222222',
          dark1 = '#282828',
          dark2 = '#303030',
          dark3 = '#404040',
          dark4 = '#525252',
        },
        overrides = {},
        dim_inactive = false,
        transparent_mode = false,
      })

      vim.o.background = "dark"
      vim.cmd([[colorscheme gruvbox]])
    end
  }
}
