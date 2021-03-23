local opt = require('utils').opt
local keymap = require('utils').keymap

local buffer = {vim.o, vim.bo}
local window = {vim.o, vim.wo}

opt('swapfile', false, buffer)
opt('undofile', true, buffer)

-- same spaces
opt('joinspaces', false)

-- do not waste vertical space
opt('cmdheight', 1)

-- goodbye flickering left bar
opt('signcolumn', "yes", window)

-- smart indenting with 2 spaces
local indent = 2
opt('shiftwidth', indent, buffer)
opt('softtabstop', indent, buffer)
opt('tabstop', indent, buffer)
opt('autoindent', true, buffer)
opt('expandtab', true, buffer)
opt('smartindent', true, buffer)

-- lines offset when scrolling
opt('scrolloff', 8)

-- sane colors
opt('termguicolors', true)

-- no visual effects during macro exeution
opt('lazyredraw', true)

-- do not destoy old buffer when changing 
opt('hidden', true)

-- word wrapping
opt('wrap', false)

-- show relative line numbers and unwanted spaces
opt('number', true, window)
opt('relativenumber', true, window)
opt('list', true, window)

-- visual clue for line length
opt('colorcolumn', "120", window)

-- full mouse support
opt('mouse', "a")

-- sane seaching
opt('ignorecase', true)
opt('smartcase', true)

opt('updatetime', 300)
opt('ttimeoutlen', 10)

-- live substitution preview
opt('inccommand', 'nosplit')

opt('confirm', true)
opt('wildmenu', true)
opt('wildmode', "full") 
opt('wildignorecase', true)
opt('wildignore', ".git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**")
opt('wildoptions', "pum")
opt('pumblend', 3 )

-- fast begin and end of line
keymap('L', '$', '', {})
keymap('H', '^', '', {})

-- leader is nop
keymap('<leader>','', 'x', {noremap = true})
keymap('<leader>','', 'n', {noremap = true})

-- quick save
keymap('<leader>w', ':w<CR>')

-- move between adjacent buffers/windows
keymap('<C-H>', '<C-W><C-H>')
keymap('<C-J>', '<C-W><C-J>')
keymap('<C-K>', '<C-W><C-K>')
keymap('<C-L>', '<C-W><C-L>')
keymap('<leader><leader>', '<C-^>')

-- folding
opt('foldlevelstart', 99)

-- hightlight yanked text
vim.cmd [[ au TextYankPost * lua vim.highlight.on_yank {on_visual = false} ]]
