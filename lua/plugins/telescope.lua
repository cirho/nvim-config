local map = require('utils').map

require('telescope').setup{
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      "-L",
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case' },
    prompt_prefix = "> ",
    selection_caret = "> ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    layout_config = {
      width = 0.75,
      horizontal = {
        mirror = false,
      },
      vertical = {
        mirror = false,
      },
      preview_cutoff = 120,
      prompt_position = "bottom",
    },
    file_sorter =  require('telescope.sorters').get_fuzzy_file,
    file_ignore_patterns = {},
    generic_sorter =  require('telescope.sorters').get_generic_fuzzy_sorter,
    path_display = {"absolute" },
    winblend = 0,
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    color_devicons = true,
    use_less = true,
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    file_previewer = require('telescope.previewers').vim_buffer_cat.new,
    grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
    qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
  }
}

map('<leader>p', [[<cmd>lua require('telescope.builtin').find_files({ follow = true })<cr>]])
map('<leader>gg', [[<cmd>lua require('telescope.builtin').git_files({ follow = true })<cr>]])
map('<leader>ge', [[<cmd>lua require('telescope.builtin').file_browser()<cr>]])
map('<leader>go', [[<cmd>lua require('telescope.builtin').oldfiles()<cr>]])
map('<leader>rg', [[<cmd>lua require('telescope.builtin').live_grep()<cr>]])
map('<leader>;', [[<cmd>lua require('telescope.builtin').buffers()<cr>]])
map('<leader>z', [[<cmd>lua require('telescope.builtin').spell_suggest()<cr>]])
map('<leader>m', [[<cmd>lua require('telescope.builtin').marks()<cr>]])
