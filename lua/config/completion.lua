local utils = require('utils')

utils.opt('completeopt', 'menuone,noselect')

-- no stupid messages 
vim.cmd [[set shortmess+=c]]

require('compe').setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = true;
    vsnip = true;
    nvim_lsp = true;
    nvim_lua = true;
    spell = true;
    tags = false;
    snippets_nvim = false;
    path = {menu = '[PATH]', priority = 9},
    treesitter = {menu = '[TS]', priority = 9},
    buffer = {menu = '[BUF]', priority = 8},
    nvim_lsp = {menu = '[LSP]', priority = 10, sort = false},
    nvim_lua = {menu = '[LUA]', priority = 8},
    vsnip = {menu = '[SNP]', priority = 10},
  };
}


-- use tab for completion instead of crtl + something
local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
  local col = vim.fn.col('.') - 1
  if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
    return true
  else
    return false
  end
end

_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t '<C-n>'
  elseif vim.fn.call('vsnip#available', {1}) == 1 then
    return t '<Plug>(vsnip-expand-or-jump)'
  elseif check_back_space() then
    return t '<Tab>'
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t '<C-p>'
  elseif vim.fn.call('vsnip#jumpable', {-1}) == 1 then
    return t '<Plug>(vsnip-jump-prev)'
  else
    return t '<S-Tab>'
  end
end


-- expr must be set to true
local opts = {silent = true, expr = true, nowait = true, noremap = true}
utils.keymap('<Tab>', 'v:lua.tab_complete()', 'i', opts)
utils.keymap('<Tab>', 'v:lua.tab_complete()', 's', opts)
utils.keymap('<S-Tab>', 'v:lua.s_tab_complete()', 'i', opts)
utils.keymap('<S-Tab>', 'v:lua.s_tab_complete()', 's', opts)

utils.keymap('<CR>', [[compe#confirm('<CR>')]], 'i', opts)
utils.keymap('<C-Space>', [[compe#complete()]], 'i', opts)
utils.keymap('<C-e>', [[compe#close('<C-e>')]], 'i', opts)
