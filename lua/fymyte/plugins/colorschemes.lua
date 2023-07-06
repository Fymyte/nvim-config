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
      custom_highlights = function(C)
        return {
          ['@class'] = { link = 'Type' },
          ['@function.macro'] = { link = 'Macro' },
          ['@property'] = { fg = C.teal },
          ['@field.lua'] = { link = '@property' },
          ['@lsp.type.variable'] = { link = '@variable' },
          CmpItemKindSnippet = { fg = C.base, bg = C.mauve },
          CmpItemKindKeyword = { fg = C.base, bg = C.red },
          CmpItemKindText = { fg = C.base, bg = C.teal },
          CmpItemKindMethod = { fg = C.base, bg = C.blue },
          CmpItemKindConstructor = { fg = C.base, bg = C.blue },
          CmpItemKindFunction = { fg = C.base, bg = C.blue },
          CmpItemKindFolder = { fg = C.base, bg = C.blue },
          CmpItemKindModule = { fg = C.base, bg = C.blue },
          CmpItemKindConstant = { fg = C.base, bg = C.peach },
          CmpItemKindField = { fg = C.base, bg = C.green },
          CmpItemKindProperty = { fg = C.base, bg = C.green },
          CmpItemKindEnum = { fg = C.base, bg = C.green },
          CmpItemKindUnit = { fg = C.base, bg = C.green },
          CmpItemKindClass = { fg = C.base, bg = C.yellow },
          CmpItemKindVariable = { fg = C.base, bg = C.flamingo },
          CmpItemKindFile = { fg = C.base, bg = C.blue },
          CmpItemKindInterface = { fg = C.base, bg = C.yellow },
          CmpItemKindColor = { fg = C.base, bg = C.red },
          CmpItemKindReference = { fg = C.base, bg = C.red },
          CmpItemKindEnumMember = { fg = C.base, bg = C.red },
          CmpItemKindStruct = { fg = C.base, bg = C.blue },
          CmpItemKindValue = { fg = C.base, bg = C.peach },
          CmpItemKindEvent = { fg = C.base, bg = C.blue },
          CmpItemKindOperator = { fg = C.base, bg = C.blue },
          CmpItemKindTypeParameter = { fg = C.base, bg = C.blue },
          CmpItemKindCopilot = { fg = C.base, bg = C.teal },
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
    enabled = false,
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
    enabled = false,
    lazy = true,
  },

  {
    'ellisonleao/gruvbox.nvim',
    enabled = false,
    config = true,
  },
}
