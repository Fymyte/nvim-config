return {
  -- Catppuccin -- Pastel colorscheme
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
    opts = {
      flavour = 'frappe',
      custom_highlights = function(colors)
        return {
          ['@class'] = { link = 'Type' },
          ['@function.macro'] = { link = 'Macro' },
          ['@property'] = { fg = colors.teal },
        }
      end,
    },
    config = function(_, opts)
      require('catppuccin').setup(opts)
      vim.cmd.colorscheme 'catppuccin'
    end,
  },

  -- Kanagawa -- Inspired by the painting of Katsushika Hokusai
  {
    'rebelot/kanagawa.nvim',
    name = 'kanagawa',
    lazy = true,
  },

  {
    'marko-cerovac/material.nvim',
    lazy = true,
  },
}
