local opt = require('utils').opt;

local global = { vim.g };

opt('tex_flavor', 'latex', global)
opt('vimtex_view_method', 'zathura', global)
opt('vimtex_quickfix_open_on_warning', 0, global)
