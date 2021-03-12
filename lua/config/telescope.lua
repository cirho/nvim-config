local utils = require('utils')

require('telescope').setup{
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
    prompt_position = "bottom",
    prompt_prefix = "> ",
    selection_caret = "> ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    layout_defaults = {
      horizontal = {
        mirror = false,
      },
      vertical = {
        mirror = false,
      },
    },
    file_sorter =  require'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = {},
    generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
    shorten_path = true,
    winblend = 0,
    width = 0.75,
    preview_cutoff = 120,
    results_height = 1,
    results_width = 0.8,
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    color_devicons = true,
    use_less = true,
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
  }
}

local opts = { noremap = true, silent = true, nowait = true};

utils.keymap('<leader>p', [[<CMD>lua require('telescope.builtin').find_files()<CR>]])
utils.keymap('<leader>fg', [[<CMD>lua require('telescope.builtin').git_files()<CR>]])
utils.keymap('<leader>fe', [[<CMD>lua require('telescope.builtin').file_browser()<CR>]])
utils.keymap('<leader>fo', [[<CMD>lua require('telescope.builtin').old_files()<CR>]])

utils.keymap('<leader>;', [[<CMD>lua require('telescope.builtin').buffers()<CR>]])
utils.keymap('<leader>a', [[<CMD>lua require('telescope.builtin').lsp_code_actions()<CR>]])
utils.keymap('<leader>d', [[<CMD>lua require('telescope.builtin').lsp_workspace_diagnostics()<CR>]])
utils.keymap('<leader>rj', [[<CMD>lua require('telescope.builtin').lsp_references()<CR>]])
