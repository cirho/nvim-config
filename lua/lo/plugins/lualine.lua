vim.opt.showmode = false

local colors = {
  black        = '#222222',
  inactivegray = '#222222',
  darkgray     = '#303030',
  lightgray    = '#a89984',
  gray         = '#404040',
  white        = '#ebdbb2',
  red          = '#fb4934',
  green        = '#b8bb26',
  blue         = '#83a598',
  yellow       = '#fabd2f',
}

local custom = {
  normal = {
    a = { bg = colors.lightgray, fg = colors.black, gui = 'bold' },
    b = { bg = colors.gray, fg = colors.white },
    c = { bg = colors.darkgray, fg = colors.lightgray }
  },
  insert = {
    a = { bg = colors.blue, fg = colors.black, gui = 'bold' },
    b = { bg = colors.gray, fg = colors.white },
    c = { bg = colors.darkgray, fg = colors.lightgray }
  },
  visual = {
    a = { bg = colors.yellow, fg = colors.black, gui = 'bold' },
    b = { bg = colors.gray, fg = colors.white },
    c = { bg = colors.darkgray, fg = colors.black }
  },
  replace = {
    a = { bg = colors.red, fg = colors.black, gui = 'bold' },
    b = { bg = colors.gray, fg = colors.white },
    c = { bg = colors.darkgray, fg = colors.white }
  },
  command = {
    a = { bg = colors.green, fg = colors.black, gui = 'bold' },
    b = { bg = colors.gray, fg = colors.white },
    c = { bg = colors.darkgray, fg = colors.black }
  },
  inactive = {
    a = { bg = colors.darkgray, fg = colors.lightgray, gui = 'bold' },
    b = { bg = colors.darkgray, fg = colors.lightgray },
    c = { bg = colors.darkgray, fg = colors.lightgray }
  }
}

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed
    }
  end
end

return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'kyazdani42/nvim-web-devicons',
    {
      'WhoIsSethDaniel/lualine-lsp-progress.nvim',
      commit = 'd76634e491076e45f465b31849d6ec320b436abb'
    }
  },
  opts = {
    options = {
      section_separators = '',
      component_separators = '|',
      icons_enabled = false,
      theme = custom,
    },
    sections = {
      lualine_b = { { 'filename', path = 1 }, 'branch' } ,
      lualine_c = { 'diagnostics', { 'diff', source = diff_source }, 'lsp_progress' },
      lualine_x = { 'filetype' },
    }
  },
}
