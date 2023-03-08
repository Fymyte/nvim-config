local render = {}

return {
  -- nvim notify -- Beautify vim.notify
  {
    'rcarriga/nvim-notify',
    opts = {
      stages = 'fade',
      fps = 60,
      timeout = 3000,
      render = function(bufnr, notif, highlights, config)
        if #notif.message > 1 then
          if #notif.title[1] > 1 then
            render.simple(bufnr, notif, highlights, config)
          else
            render.minimal(bufnr, notif, highlights)
          end
        else
          render.compact(bufnr, notif, highlights)
        end
      end,
    },
    config = function(_, opts)
      local notify = require 'notify'
      render.minimal = require 'notify.render.minimal'
      render.compact = require 'notify.render.compact'
      render.simple = require 'notify.render.simple'
      notify.setup(opts)
      vim.notify = notify
    end,
  },

  -- -- Lsp notifications and progress in bottom right corner
  -- {
  --   'vigoux/notifier.nvim',
  --   opts = {
  --     components = { 'lsp' },
  --     notify = { clear_time = 2000 },
  --   },
  -- },

  -- dressing.nvim -- Beautify vim.ui.input
  {
    'stevearc/dressing.nvim',
    opts = { input = { insert_only = false } },
    event = 'VeryLazy',
  },

  -- lualine -- Better statusline
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        --    theme = theme,
        section_separators = '',
        component_separators = { left = '∣', right = '∣' },
        globalstatus = true,
      },
      sections = {
        lualine_b = {
          { 'branch', icon = '' },
          'diff',
          {
            'diagnostics',
            sources = { 'nvim_diagnostic', 'nvim_lsp' },
            symbols = { error = ' ', warn = ' ', hint = ' ', info = ' ' },
          },
        },
        lualine_c = { '%=%t%m', 'filetype' },
        lualine_x = { 'encoding', 'fileformat' },
      },
    },
  },

  -- Noicer cmd
  {
    'folke/noice.nvim',
    enabled = false,
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
      'hrsh7th/nvim-cmp',
    },
    opts = {
      cmdline = {
        view = 'cmdline',
      },
      popupmenu = {
        backend = 'cmp',
      },
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
        progress = {
          enabled = true,
          format = {
            '({data.progress.percentage}%) ',
            { '{spinner} ', hl_group = 'NoiceLspProgressSpinner' },
            { '{data.progress.title} ', hl_group = 'NoiceLspProgressTitle' },
            { '{data.progress.client} ', hl_group = 'NoiceLspProgressClient' },
          },
        },
      },
      routes = {
        {
          skip = true,
          filter = {
            any = {
              {
                event = 'notify',
                warning = true,
                find = 'multiple different client offset_encodings',
              },
            },
          },
        },
      },
      presets = {
        lsp_doc_border = true,
      },
    },
  },
}
