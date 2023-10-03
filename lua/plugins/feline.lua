local colors = {
  bg = '#282c34',
  fg = '#abb2bf',
  section_bg = '#38393f',
  blue = '#61afef',
  green = '#98c379',
  purple = '#c678dd',
  orange = '#e5c07b',
  red = '#e06c75',
  yellow = '#e5c07b',
  darkgrey = '#2c323d',
  middlegrey = '#8791A5',
}

local vi_mode_colors = {
  NORMAL = 'green',
  OP = 'red',
  INSERT = 'blue',
  VISUAL = 'purple',
  LINES = 'purple',
  BLOCK = 'purple',
  REPLACE = 'red',
  ['V-REPLACE'] = 'purple',
  ENTER = 'blue',
  MORE = 'blue',
  SELECT = 'orange',
  COMMAND = 'green',
  SHELL = 'green',
  TERM = 'blue',
  NONE = 'yellow',
}

local file_info = function()
  local bufnr = vim.api.nvim_win_get_buf(0)
  local filename = vim.api.nvim_buf_get_name(bufnr)
  if filename == '' then
    filename = '[unnamed]'
  end

  filename = vim.fn.fnamemodify(filename, ':~:.')

  local readonly_str = vim.bo.readonly and ' ' or ''
  local modified_str = vim.bo.modified and ' ' or ''

  return ' ' .. readonly_str .. filename .. ' ' .. modified_str
end

return {
  'feline-nvim/feline.nvim',
  dependencies = {
    'kyazdani42/nvim-web-devicons',
    'nvim-lua/lsp-status.nvim',
  },
  config = function()
    local lazy_require = require('feline.utils').lazy_require
    local lspstatus = lazy_require('lsp-status')

    vim.opt.showmode = false

    -- attach to a lsp server
    local lsp_symbol = ' '

    lspstatus.config({
      status_symbol = lsp_symbol,
      diagnostics = false
    })

    lspstatus.register_progress()

    local lsp_check_diagnostics = function ()
      if not vim.tbl_isempty(vim.lsp.buf_get_clients()) then
        local output = lspstatus.status()
        if output == lsp_symbol .. ' ' then return output .. 'ready ' end
        return output
      end
      return ''
    end

    local vi_mode = lazy_require 'feline.providers.vi_mode'

    local components = {
      active = { {}, {} },
      inactive = { {} },
    }

    -- create statusline
    local push = table.insert
    local left_side = components.active[1]
    local right_side = components.active[2]

    push(left_side, {
      provider = function()
        return string.format(' %s ', vi_mode.get_vim_mode())
      end,
      short_provider = function()
        return string.format(' %s ', vi_mode.get_vim_mode():sub(1, 1))
      end,
      icon = '',
      hl = function() return { fg = 'bg', bg = vi_mode.get_mode_color(), style = 'bold' } end,
    })
    push(left_side, {
      provider = file_info,
      hl = { fg = 'fg', bg = 'section_bg' },
      right_sep = {
        str = 'slant_right',
        hl = { fg = 'section_bg', bg = 'bg' }
      },
    })
    push(left_side, { provider = lsp_check_diagnostics, hl = { fg = 'middlegrey', bg = 'bg', } })
    push(left_side, { provider = 'diagnostic_errors', icon = ' E ', hl = { fg = 'red', bg = 'bg', } })
    push(left_side, { provider = 'diagnostic_warnings', icon = ' W ', hl = { fg = 'orange', bg = 'bg', } })
    push(left_side, { provider = 'diagnostic_info', icon = ' I ', hl = { fg = 'blue', bg = 'bg', } })
    push(left_side, { provider = 'diagnostic_hints', icon = ' H ', hl = { fg = 'cyan', bg = 'bg' } })

    push(right_side, { provider = 'git_diff_added', icon = '+', hl = { fg = 'green', bg = 'bg', }, right_sep = ' ' })
    push(right_side, { provider = 'git_diff_changed', icon = '~', hl = { fg = 'orange', bg = 'bg', }, right_sep = ' ' })
    push(right_side, { provider = 'git_diff_removed', icon = '-', hl = { fg = 'red', bg = 'bg', }, right_sep = ' ' })
    push(right_side, { provider = 'git_branch', hl = { fg = 'middlegrey', bg = 'bg', }, right_sep = ' ' })
    push(right_side, { provider = function() return vim.bo.filetype end, right_sep = ' ' })
    push(right_side, {
      provider = {
        name = 'position',
        opts = { padding = true },
      },
      hl = { fg = 'bg', bg = 'blue' },
      left_sep = {
        str = 'slant_left',
        hl = { fg = 'blue', bg = 'bg', },
      },
      right_sep = {
        str = ' ',
        hl = { bg = 'blue' }
      }
    })


    push(components.inactive[1], {
      provider = file_info,
      hl = { fg = 'fg', bg = 'section_bg', },
      right_sep = {
        str = 'slant_right',
        hl = { fg = 'section_bg', bg = 'bg' },
      },
    })

    require('feline').setup {
      theme = colors,
      vi_mode_colors = vi_mode_colors,
      components = components,
      force_inactive = {
        filetypes = {},
        buftypes = {},
        bufnames = {},
      },
    }
  end
}
