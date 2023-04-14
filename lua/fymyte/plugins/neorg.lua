return {
  'nvim-neorg/neorg',
  build = ':Neorg sync-parsers',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-neorg/neorg-telescope',
    'hrsh7th/nvim-cmp',
  },
  opts = {
    load = {
      ['core.defaults'] = {}, -- Load all the default modules
      ['core.keybinds'] = {
        config = {
          hook = function(keybinds)
            keybinds.unmap('norg', 'n', '<M-j>')
            keybinds.unmap('norg', 'n', '<M-k>')
          end,
        },
      },
      ['core.norg.concealer'] = {
        config = {
          icon_preset = 'diamond',
        },
      }, -- Allows for use of icons
      ['core.norg.qol.toc'] = {},
      -- ["core.gtd.base"] = {
      --   config = {
      --     workspace = "gtd",
      --   }
      -- },
      ['core.norg.dirman'] = { -- Manage your directories with Neorg
        config = {
          workspaces = {
            notes = '~/Documents/notes/',
            work = '~/Documents/dev/doc/notes/',
            -- gtd = "~/Documents/notes/gtd",
          },
          default_workspace = 'work',
        },
      },
      ['core.norg.completion'] = {
        config = {
          engine = 'nvim-cmp', -- We current support nvim-compe and nvim-cmp only
        },
      },
      ['core.export'] = {},
      ['core.export.markdown'] = {},
      ['core.presenter'] = {
        config = {
          zen_mode = 'truezen',
        },
      },
      ['core.integrations.telescope'] = {},
    },
  },
}
