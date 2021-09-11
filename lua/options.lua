local opt = vim.opt
local cmd = vim.cmd

local map = require('utils').map

opt.swapfile = false
opt.undofile = true

-- same spaces
opt.joinspaces = false

-- do not waste vertical space
opt.cmdheight = 1

-- goodbye flickering left bar
opt.signcolumn = 'yes'

-- smart indenting with 2 spaces
local indent = 2
opt.shiftwidth = indent
opt.softtabstop = indent
opt.tabstop = indent
opt.autoindent = true
opt.expandtab = true
opt.smartindent = true

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

-- show relative line numbers and unwanted spaces
opt.number = true
opt.relativenumber = true
opt.list = true

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
  '.git', '*.pyc', '*.o', '*.out', '*.e', '*.tar.*', '*.tar','*.zip', '**/tmp/**', '**/node_modules/**',
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

-- folding
opt.foldlevelstart = 99

-- hightlight yanked text
cmd [[ au TextYankPost * lua vim.highlight.on_yank {on_visual = false} ]]
