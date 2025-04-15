---@type LazyPluginSpec
return {
  'echasnovski/mini.move',
  event = 'VeryLazy',
  version = false,
  config = function(_, opts)
    require('mini.move').setup(opts)
  end,
}
