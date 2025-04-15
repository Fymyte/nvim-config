---@type LazyPluginSpec
return {
  'catppuccin/nvim',
  name = 'catppuccin',
  lazy = false,
  priority = 1000,
  build = function()
    require('catppuccin').compile()
  end,
  ---@type CatppuccinOptions
  opts = {
    flavour = 'mocha',
    integrations = { blink_cmp = true },
  },
  config = function(_, opts)
    require('catppuccin').setup(opts)
    vim.cmd.colorscheme 'catppuccin'
  end,
}
