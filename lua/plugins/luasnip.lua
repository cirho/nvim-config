return {
  'neovim/nvim-lspconfig',
  config = function()
    require("luasnip.loaders.from_lua").load({
      paths = os.getenv('XDG_CONFIG_HOME') .. '/nvim/snippets/'
    })
  end
}
