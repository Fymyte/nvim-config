-- Make sure builtin parser are managed by nvim-treesitter as well so they receive updates as well
local builtin_parsers = {
  'c',
  'lua',
  'vim',
  'vimdoc',
  'markdown',
  'markdown_inline',
  'query',
}

---@type LazyPluginSpec
return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false,
  build = function()
    require('nvim-treesitter').install(builtin_parsers)
    require('nvim-treesitter').update()
  end,
  version = false,
}
