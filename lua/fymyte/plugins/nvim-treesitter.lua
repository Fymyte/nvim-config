---@type LazyPluginSpec
return {
  'nvim-treesitter/nvim-treesitter',
  build = function()
    require('nvim-treesitter.install').update()
  end,
  version = false,

  ---@type TSConfig
  opts = {
    auto_install = true,
  },

  config = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)
  end,
}
