vim.pack.add { Utils.gh 'catgoose/nvim-colorizer.lua' }

require('colorizer').setup {
  options = {
    parsers = {
      names = {
        enable = false,
        lowercase = false,
        camelcase = false,
        uppercase = false,
        strip_digits = false,
        custom = false,
      },
      sass = { enable = true, parsers = { 'css' } },
    },
    display = {
      mode = 'virtualtext',
      virtualtext = {
        char = '',
        position = 'after',
      },
    },
  },

  filetypes = {
    '*',
    css = { css = true },
    scss = { css = true },
    html = { css = true },
  },
}
