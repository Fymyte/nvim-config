vim.pack.add {
  {
    src = Utils.gh 'nvim-mini/mini.ai',
    version = vim.version.range '*',
  },
  {

    src = Utils.gh 'nvim-mini/mini.align',
    version = vim.version.range '*',
  },
  {
    src = Utils.gh 'nvim-mini/mini.jump',
    version = vim.version.range '*',
  },
  {
    src = Utils.gh 'nvim-mini/mini.move',
    version = vim.version.range '*',
  },
}

require('mini.ai').setup {
  mappings = {
    around_last = '',
    inside_last = '',
  },
}
require('mini.align').setup()
require('mini.jump').setup {
  delay = { idle_stop = 2000 },
}
require('mini.move').setup()
