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
      '--smart-case',
    },
    -- path_display = { "absolute" },
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
  }
}

local map = function(key, fn)
  vim.keymap.set('n', key, fn, { silent = true, noremap = true, nowait = true })
end

local tb = require('telescope.builtin')
map('<leader>gg', tb.git_files)
map('<leader>go', tb.oldfiles)
map('<leader>rg', tb.live_grep)
map('<leader>p', function()
  tb.find_files({
    find_command = { 'fd', '--type', 'f', '-E', 'qemu', }
  })

end)
map('<leader>;', tb.buffers)
map('<leader>m', tb.marks)
