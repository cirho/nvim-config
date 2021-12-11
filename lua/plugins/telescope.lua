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
      '--smart-case'
    },
    layout_config = {
      width = 0.95,
      height = 0.85,
      -- prompt_position = "top",
      horizontal = {
        preview_width = function(_, cols, _)
          if cols > 200 then
            return math.floor(cols * 0.4)
          else
            return math.floor(cols * 0.6)
          end
        end,
      },
      vertical = {
        width = 0.9,
        height = 0.95,
        preview_height = 0.5,
      },
      flex = {
        horizontal = {
          preview_width = 0.9,
        },
      },
    },
    path_display = { "absolute" },
    set_env = { ['COLORTERM'] = 'truecolor' }
  },
  pickers = {
    buffers = {
      theme = 'dropdown'
    },
    find_files = {
      follow = true,

    },
    git_files = {
      folow = true
    },
    diagnostics = {
      initial_mode = 'normal',
      theme = 'dropdown'
    },
    lsp_code_actions = {
      initial_mode = 'normal',
      theme = 'dropdown'
    },
    spell_suggest = {
      initial_mode = 'normal',
    },
    lsp_references = {
      initial_mode = 'normal',
      theme = 'dropdown'
    }
  }
}

local map_tele = function(key, fn)
  map(key, string.format('<cmd>lua require("telescope.builtin").%s()<cr>', fn))
end

map_tele('<leader>p', 'find_files')
map_tele('<leader>gg', 'git_files')
map_tele('<leader>ge', 'file_browser')
map_tele('<leader>go', 'oldfiles')
map_tele('<leader>rg', 'live_grep')
map_tele('<leader>;', 'buffers')
map_tele('<leader>m', 'marks')
