local ls = require("luasnip")
local scan = require('plenary.scandir')

local root_path = os.getenv('XDG_CONFIG_HOME') .. '/nvim/snippets/'
local files = scan.scan_dir(root_path, { search_pattern = '.lua' })

local snips = {}
for _, path in ipairs(files) do
  local p,q = path:find('%w*%.lua')
  local ft = path:sub(p, q - 4)

  snips[ft] = loadfile(path)()
end

ls.snippets = vim.tbl_extend('force', snips, {
  all = {},
})
