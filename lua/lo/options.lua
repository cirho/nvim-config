local map = require('lo.utils').map

vim.opt.swapfile = false
vim.opt.undofile = true

-- highlight current line
vim.opt.cursorline = true

-- same spaces
vim.opt.joinspaces = false

-- do not waste vertical space
vim.opt.cmdheight = 1

-- goodbye flickering left bar
vim.opt.signcolumn = 'yes:3'

-- smart indenting with 4 spaces
local indent = 4
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.tabstop = indent
vim.opt.shiftwidth = indent
vim.opt.softtabstop = indent

-- smart whitespace display
vim.opt.list = true
vim.opt.listchars = {
    tab = "<->",
    nbsp = "+",
    extends = "·",
    precedes = "·",
    trail = "-",
    multispace = "-",
    leadmultispace = " ",
}

-- lines offset when scrolling
vim.opt.scrolloff = 8

-- sane colors
vim.opt.termguicolors = true

-- no visual effects during macro exeution
vim.opt.lazyredraw = true

-- do not destoy old buffer when changing
vim.opt.hidden = true

-- word wrapping
vim.opt.wrap = false

-- show relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- visual clue for line length
vim.opt.colorcolumn = "120"

-- full mouse support
vim.opt.mouse = 'a'

-- sane seaching
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.updatetime = 300
vim.opt.ttimeoutlen = 10

-- live substitution preview
vim.opt.inccommand = 'nosplit'

vim.opt.confirm = true
vim.opt.wildmenu = true
vim.opt.wildmode = 'full'
vim.opt.wildignorecase = true
vim.opt.wildignore = {
  '.git', '*.pyc', '*.o', '*.out', '*.e', '*.tar.*', '*.tar','*.zip', '**/tmp/**',
}
vim.opt.wildoptions = 'pum'
vim.opt.pumblend = 3

-- fast begin and end of line
map('L', '$', '', {})
map('H', '^', '', {})

-- leader is nop
map('<leader>', '', 'x', { noremap = true })
map('<leader>', '', 'n', { noremap = true })

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
vim.opt.foldlevelstart = 99

-- hightlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function() vim.highlight.on_yank({ on_visual = true }) end
})
