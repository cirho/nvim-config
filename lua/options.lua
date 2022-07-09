local opt = vim.opt

local map = require('utils').map

opt.swapfile = false
opt.undofile = true

-- same spaces
opt.joinspaces = false

-- do not waste vertical space
opt.cmdheight = 1

-- goodbye flickering left bar
opt.signcolumn = 'yes:3'

-- smart indenting with 4 spaces
local indent = 4
opt.shiftwidth = indent
opt.softtabstop = indent
opt.tabstop = indent
opt.autoindent = true
opt.expandtab = true
opt.smartindent = true
opt.list = false

-- lines offset when scrolling
opt.scrolloff = 8

-- sane colors
opt.termguicolors = true

-- no visual effects during macro exeution
opt.lazyredraw = true

-- do not destoy old buffer when changing
opt.hidden = true

-- word wrapping
opt.wrap = false

-- show relative line numbers
opt.number = true
opt.relativenumber = true

-- visual clue for line length
opt.colorcolumn = "120"

-- full mouse support
opt.mouse = 'a'

-- sane seaching
opt.ignorecase = true
opt.smartcase = true

opt.updatetime = 300
opt.ttimeoutlen = 10

-- live substitution preview
opt.inccommand = 'nosplit'

opt.confirm = true
opt.wildmenu = true
opt.wildmode = 'full'
opt.wildignorecase = true
opt.wildignore = {
  '.git', '*.pyc', '*.o', '*.out', '*.e', '*.tar.*', '*.tar','*.zip', '**/tmp/**',
}
opt.wildoptions = 'pum'
opt.pumblend = 3

-- fast begin and end of line
map('L', '$', '', {})
map('H', '^', '', {})

-- leader is nop
map('<leader>','', 'x', { noremap = true })
map('<leader>','', 'n', { noremap = true })

-- quick save
map('<leader>w', ':w<CR>')

-- move between adjacent buffers/windows
map('<C-H>', '<C-W><C-H>')
map('<C-J>', '<C-W><C-J>')
map('<C-K>', '<C-W><C-K>')
map('<C-L>', '<C-W><C-L>')
map('<leader><leader>', '<C-^>')
map('<leader>z', '1z=')
map('<C-g>', ':bd<cr>')
-- folding
opt.foldlevelstart = 99

-- hightlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function() vim.highlight.on_yank({ on_visual = true }) end
})
