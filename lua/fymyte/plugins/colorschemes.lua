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
          ['@field.lua'] = { link = '@property' },
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
    opts = {
      undercurl = true, -- enable undercurls
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = true },
      statementStyle = { bold = true },
      typeStyle = {},
      variablebuiltinStyle = { italic = true },
      specialReturn = true, -- special highlight for the return keyword
      specialException = true, -- special highlight for exception handling keywords
      transparent = false, -- use background colors defined above
      dimIncative = false,
      globalStatus = false,
      colors = {
        sumiInk1 = '#212121',
        sumiInk0 = '#2A2A2A',
        sumiInk2 = '#353535',
        sumiInk3 = '#414141',
        sumiInk4 = '#5F5F5F',

        waveBlue1 = '#2F2F2F',
        waveBlue2 = '#393939',
      },
      overrides = {
        -- TSVariable = { fg = "#ECD2A2" }
        TSVariable = { link = 'TSField' },
      },
    },
  },

  {
    'marko-cerovac/material.nvim',
    lazy = true,
  },
}
