---@type LazyPluginSpec
return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false,
  build = function()
    require('nvim-treesitter').update()
  end,
  version = false,
}
