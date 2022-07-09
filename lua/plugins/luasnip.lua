local root_path = os.getenv('XDG_CONFIG_HOME') .. '/nvim/snippets/'

require("luasnip.loaders.from_lua").load({paths = root_path})
