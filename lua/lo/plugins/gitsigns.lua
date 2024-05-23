return {
  'lewis6991/gitsigns.nvim',
  opts = {
    signs = {
      add          = { hl = 'DiffAdd'   , text = '│', numhl='GitSignsAddNr' },
      change       = { hl = 'DiffChange', text = '│', numhl='GitSignsChangeNr' },
      delete       = { hl = 'DiffDelete', text = '_', numhl='GitSignsDeleteNr' },
      topdelete    = { hl = 'DiffDelete', text = '‾', numhl='GitSignsDeleteNr' },
      changedelete = { hl = 'DiffChange', text = '~', numhl='GitSignsChangeNr' },
    },
    numhl = false,
    on_attach = function(bufnr)
      local opts = { silent = true, noremap = true, nowait = true, buffer = bufnr }
      local gs = package.loaded.gitsigns
      local map = function(mode, key, fn)
        vim.keymap.set(mode, key, fn, opts)
      end

      map('n', ']g', function() vim.schedule(gs.next_hunk) end)
      map('n', '[g', function() vim.schedule(gs.prev_hunk) end)

      map('n', '<leader>hs', gs.stage_hunk)
      map('n', '<leader>hr', gs.reset_hunk)
      map('v', '<leader>hs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
      map('v', '<leader>hr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)

      map('n', '<leader>hu', gs.undo_stage_hunk)

      map('n', '<leader>hS', gs.stage_buffer)
      map('n', '<leader>hR', gs.reset_buffer)

      map('n', '<leader>hp', gs.preview_hunk)
      map('n', '<leader>hb', gs.blame_line)
    end,
    watch_gitdir = {
      interval = 1000,
      follow_files = true
    },
    sign_priority = 6,
    status_formatter = nil,
    preview_config = {
      border = 'none'
    },
  }
}
