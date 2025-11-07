---@type LazyPluginSpec
return {
  'catgoose/nvim-colorizer.lua',
  -- event = 'BufReadPre',
  ---@module "colorizer.config"
  opts = {
    user_default_options = {
      names = false,
      sass = { enable = true, parsers = { 'css' } },
      mode = 'virtualtext',
      virtualtext = '',
      virtualtext_inline = true,
    },

    filetypes = {
      '*',
      css = { css = true },
      scss = { css = true },
      html = { css = true },
    },
  },
}
