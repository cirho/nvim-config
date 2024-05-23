return {
  'nvim-telescope/telescope.nvim',
  dependencies = { 'nvim-telescope/telescope-ui-select.nvim', 'nvim-lua/plenary.nvim' },
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
        lsp_references = { initial_mode = 'normal' },
        diagnostics = { theme = 'dropdown' }
      },
      extensions = {
        ["ui-select"] = { require("telescope.themes").get_cursor(), },
      },
    })

    local map = function(key, fn)
      vim.keymap.set('n', key, fn, { silent = true, noremap = true, nowait = true })
    end

    local tb = require('telescope.builtin')
    map('<leader>fg', tb.git_files)
    map('<leader>fo', tb.oldfiles)
    map('<leader>s', tb.lsp_document_symbols)
    map('<leader>S', tb.lsp_workspace_symbols)
    map('<leader>/', tb.live_grep)
    map('<leader>p', tb.find_files)
    map('<leader>;', tb.buffers)
    map('<leader>m', tb.marks)
    map('<leader>d', tb.diagnostics)

    require('telescope').load_extension("ui-select")
    require('telescope').load_extension('projects')

    vim.api.nvim_create_autocmd('VimEnter', {
      callback = function()
        if vim.fn.argc() == 0 then
          require('telescope').extensions.projects.projects({})
        end
      end
    })
  end
}
