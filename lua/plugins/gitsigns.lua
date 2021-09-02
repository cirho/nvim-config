require('gitsigns').setup {
  signs = {
    add          = {hl = 'DiffAdd'   , text = '│', numhl='GitSignsAddNr'},
    change       = {hl = 'DiffChange', text = '│', numhl='GitSignsChangeNr'},
    delete       = {hl = 'DiffDelete', text = '_', numhl='GitSignsDeleteNr'},
    topdelete    = {hl = 'DiffDelete', text = '‾', numhl='GitSignsDeleteNr'},
    changedelete = {hl = 'DiffChange', text = '~', numhl='GitSignsChangeNr'},
  },
  numhl = false,
  keymaps = {
    noremap = true,
    buffer = true,

    ['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<cr>'"},
    ['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<cr>'"},

    ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<cr>',
    ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<cr>',
    ['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<cr>',
    ['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<cr>',
    ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line()<cr>',

    -- text objects
    ['o ih'] = ':<C-U>lua require"gitsigns".text_object()<cr>',
    ['x ih'] = ':<C-U>lua require"gitsigns".text_object()<cr>'
  },
  watch_index = {
    interval = 1000
  },
  sign_priority = 6,
  status_formatter = nil,
}
