vim.opt.showmode = false

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
    },
    sections = {
      lualine_b = { 'branch', { 'diff', source = diff_source }, 'diagnostics' } ,
      lualine_c = { 'filename', 'lsp_progress' },
      lualine_x = { 'filetype'},
    }
  },
}
