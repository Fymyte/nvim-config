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
      ---Filter notifications
      ---@param msg string
      ---@param level integer
      ---@param opts table
      -- selene: allow(shadowing)
      ---@diagnostic disable-next-line:redefined-local
      local filtered_notify = function(msg, level, opts)
        local start = 'warning: multiple different client offset_encodings detected for buffer'
        if level == vim.log.levels.WARN and msg:sub(1, #start) == start then
          return
        end
        notify(msg, level, opts)
      end
      vim.notify = filtered_notify
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

  {
    'nvim-treesitter/nvim-treesitter-context',
  },

  -- dressing.nvim -- Beautify vim.ui.input
  {
    'stevearc/dressing.nvim',
    opts = { input = { insert_only = false } },
    event = 'VeryLazy',
  },

  -- lualine -- Better statusline
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 
      'linrongbin16/lsp-progress.nvim',
      opts = {
        spinner = { '🌑 ', '🌒 ', '🌓 ', '🌔 ', '🌕 ', '🌖 ', '🌗 ', '🌘 ' },
        client_format = function(client, spinner, _)
          return ("[" .. client .. "] " .. spinner)
        end,
        format = function(msgs)
          if #msgs > 0 then
            return table.concat(msgs, " ")
          end
          return ""
        end,
      },
    },
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
        lualine_c = { '%=%f', 'filetype' },
        lualine_x = {
          function() return require('lsp-progress').progress() end,
          'encoding',
          'fileformat',
        },
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
      lsp = { progress = { enabled = false } },
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

  {
    'declancm/maximize.nvim',
    config = true,
  },

  {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      columns = {
        'size',
        'icon',
      },
      lsp_file_methods = {
        autosave_changes = true,
      },
      experimental_watch_for_changes = true,
    },
    config = function(_, opts)
      require('oil').setup(opts)
      vim.keymap.set('n', '<leader>o', require('oil').open, {
        silent = true,
        desc = "[O]il open current file's directory",
      })
    end,
  },

  -- Toggleable terminal
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    opts = {
      size = function(term)
        if term.direction == 'horizontal' then
          return 15
        elseif term.direction == 'vertical' then
          return vim.o.columns * 0.4
        end
      end,
      open_mapping = [[<m-i>]],
      direction = 'vertical',
      shading_factor = -20,
      float_opts = { border = 'rounded' },
    },
    keys = {
      { [[<m-i>]] },
      { '<c-w>', [[<c-\><c-n><c-w>]], mode = 't' },
      { [[<c-'><c-'>]], [[<c-\><c-n>]], mode = 't' },
    },
  },

  -- Show an undotree window
  {
    'mbbill/undotree',
    keys = { { '<F5>', '<cmd>UndotreeToggle<cr>', desc = 'Toggle undo tree' } },
    cmd = 'UntotreeToggle',
  },

  -- Builtin basic shell commands
  'tpope/vim-eunuch',
}
