return {

  { 'mboughaba/i3config.vim', ft = { 'i3config', 'i3' } },
  { 'fladson/vim-kitty', ft = 'kitty' },
  { 'Fymyte/mbsync.vim', ft = 'mbsync' },
  { 'amadeus/vim-css', ft = { 'css', 'stylus', 'sass', 'scss' } },
  { 'kmonad/kmonad-vim' },

  {
    'LhKipp/nvim-nu',
    ft = 'nu',
    build = ':TSInstall nu',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'jose-elias-alvarez/null-ls.nvim',
    },
    config = true,
  },

  {
    'nvim-colortils/colortils.nvim',
    opts = {
      register = '+',
      color_preview = '█ %s',
      default_format = 'hex',
      border = 'rounded',
      mappings = {
        increment_big = 'L',
        decrement_big = 'H',
      },
    },
    enabled = false,
  },
  {
    'NvChad/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup({ RRGGBBAA = true, css = true })
    end,
  },
}
