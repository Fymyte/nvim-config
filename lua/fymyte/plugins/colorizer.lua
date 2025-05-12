---@type LazyPluginSpec
return {
  'catgoose/nvim-colorizer.lua',
  event = 'BufReadPre',
  ---@module "colorizer.config"
  opts = {
    user_default_options = {
      names = false,
      mode = 'virtualtext',
      virtualtext = '',
      virtualtext_inline = true,
    },
  },
}
