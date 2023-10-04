return {
  'nvim-telescope/telescope.nvim',
  dependencies = { 'nvim-telescope/telescope-ui-select.nvim' },
  config = function()
    require('telescope').setup({
      defaults = {
        vimgrep_arguments = {
          'rg',
          '--color=never',
          '--no-heading',
          "-L",
          '--with-filename',
          '--line-number',
          '--column',
          '--smart-case',
        },
        set_env = { ['COLORTERM'] = 'truecolor' }
      },
      pickers = {
        buffers = { theme = 'dropdown' },
        find_files = { follow = true, },
        git_files = { folow = true, theme='cursor' },
        diagnostics = { initial_mode = 'normal' },
        spell_suggest = { initial_mode = 'normal', },
        lsp_code_actions = { initial_mode = 'normal', theme = 'dropdown' },
        lsp_references = { initial_mode = 'normal', theme = 'dropdown' }
      },
      extensions = {
        ["ui-select"] = { require("telescope.themes").get_cursor(), },
      },
    })

    local map = function(key, fn)
      vim.keymap.set('n', key, fn, { silent = true, noremap = true, nowait = true })
    end

    local tb = require('telescope.builtin')
    map('<leader>gg', tb.git_files)
    map('<leader>go', tb.oldfiles)
    map('<leader>rg', tb.live_grep)
    map('<leader>p', function() tb.find_files({ find_command = { 'fd', '--type', 'f' } }) end)
    map('<leader>;', tb.buffers)
    map('<leader>m', tb.marks)

    require('telescope').load_extension("ui-select")
  end
}
