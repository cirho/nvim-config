local compare_kind = function(entry1, entry2)
  local types = require('cmp.types')
  local kind1 = entry1:get_kind()
  local kind2 = entry2:get_kind()
  kind1 = kind1 == types.lsp.CompletionItemKind.Text and 100 or kind1
  kind2 = kind2 == types.lsp.CompletionItemKind.Text and 100 or kind2
  if kind1 ~= kind2 then
    local diff = kind1 - kind2
    if diff < 0 then
      return true
    elseif diff > 0 then
      return false
    end
  end
  return nil
end

return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-nvim-lua',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'ray-x/cmp-treesitter',
    'saadparwaiz1/cmp_luasnip',
    'L3MON4D3/luasnip',
  },
  event = 'InsertEnter',
  config = function()
    local cmp = require('cmp')
    local luasnip = require('luasnip')

    -- no stupid messages
    vim.opt.shortmess:append({ c = true })

    local has_words_before = function()
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
    end

    cmp.setup({
      snippet = {
        expand = function(args) require('luasnip').lsp_expand(args.body) end
      },
      formatting = {
        format = function(entry, vim_item)
          vim_item.menu = ({
            buffer = '[buf]',
            nvim_lsp = '[lsp]',
            nvim_lua = '[nvim]',
            path = '[path]',
            luasnip = '[snip]',
            treesitter = '[tree]'
          })[entry.source.name]

          return vim_item
        end,
      },
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
        ["<C-n>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }
        ),
        ["<C-p>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<C-y>'] = cmp.mapping.confirm({
          select = true,
        })
      },
      sources = {
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'luasnip', } ,
        { name = 'path' },
        { name = 'treesitter' },
        { name = 'buffer', keyword_length = 3, option = {
            max_item_count = 15,
            max_indexed_line_length = 500,
            get_bufnrs = function()
              local buf = vim.api.nvim_get_current_buf()
              local byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
              if byte_size > 1024 * 1024 then
                return {}
              end
              return { buf }
            end
          },
        },
      }
    })
  end
}
