local opt = vim.opt

local cmp = require('cmp')

local map = require('utils').map

-- no stupid messages 
opt.shortmess:append({ c = true })

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  formatting = {
    format = function(entry, vim_item)
      vim_item.menu = ({
        buffer = "[BUF]",
        nvim_lsp = "[LSP]",
        nvim_lua = "[NVIM]",
        path = "[PATH]",
        vsnip = "[SNIP]",
      })[entry.source.name]

      return vim_item
    end,
  },
  mapping = {
    ['<cr>'] = cmp.mapping.confirm({ select = false, behavior = cmp.ConfirmBehavior.Insert, }),
    ['<c-space>'] = cmp.mapping.complete(),
    ['<tab>'] = cmp.mapping(function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n', true)
      elseif has_words_before() and vim.fn['vsnip#available']() == 1 then
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Plug>(vsnip-expand-or-jump)', true, true, true), '', true)
      else
        fallback() 
      end
    end, { 'i', 's' }),
    ['<s-tab>'] = cmp.mapping(function()
      if vim.fn.pumvisible() == 1 then
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-p>', true, true, true), 'n', true)
      elseif vim.fn['vsnip#jumpable'](-1) == 1 then
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Plug>(vsnip-jump-prev)', true, true, true), '', true)
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'path' },
    { name = 'buffer', max_item_count = 15 },
    { name = 'vsnip' },
  }
})
