return {
  -- Catppuccin -- Pastel colorscheme
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
    build = function()
      require('catppuccin').compile()
    end,
    opts = {
      flavour = 'mocha',
    },
    config = function(_, opts)
      require('catppuccin').setup(opts)
      vim.cmd.colorscheme 'catppuccin'
    end,
  },
}
