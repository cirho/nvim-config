return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'ray-x/cmp-treesitter',
    'saadparwaiz1/cmp_luasnip',
    'L3MON4D3/luasnip',
  },
  lazy = false,
  config = function()
    local cmp = require('cmp')
    local ls = require('luasnip')

    -- no stupid messages
    vim.opt.shortmess:append({ c = true })

    cmp.setup({
      snippet = { expand = function(args) require('luasnip').lsp_expand(args.body) end },
      sorting = {
        priority_weight = 2,
        comparators = {
          cmp.config.compare.score,
          cmp.config.compare.offset,
          cmp.config.compare.exact,
          cmp.config.compare.recently_used,
        }
      },
      mapping = {
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-k>'] = cmp.mapping(function() if ls.jumpable(-1) then ls.jump(-1) end end, { "i", "s" }),
        ['<C-j>'] = cmp.mapping(function() if ls.expand_or_jumpable() then ls.expand_or_jump() end end, { "i", "s" }),
        ['<C-space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<C-y>'] = cmp.mapping.confirm({ select = true })
      },
      sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip', } ,
        { name = 'path' },
        { name = 'treesitter' },
        { name = 'buffer', keyword_length = 3, },
      }
    })

  end
}
