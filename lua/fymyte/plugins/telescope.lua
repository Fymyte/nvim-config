local system_deps = require('fymyte.utils').system_deps
local check_system_deps = require('fymyte.utils').check_system_deps

---@type LazyPluginSpec
return {
  'nvim-telescope/telescope.nvim',
  build = function()
    check_system_deps({ 'fd', 'rg' }, 'telescope')
  end,
  dependencies = (function()
    local telescope_deps = {
      'nvim-telescope/telescope-project.nvim',
      'nvim-telescope/telescope-ui-select.nvim',
      'nvim-telescope/telescope-live-grep-args.nvim',
      'nvim-lua/plenary.nvim',
    }

    local missing_deps = system_deps('make', { 'gcc', 'clang' })
    if #missing_deps == 0 then
      table.insert(telescope_deps, { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' })
    else
      vim.notify('missing deps for fzf: ' .. vim.inspect(missing_deps), vim.log.levels.WARN, { title = 'Telescope' })
    end

    return telescope_deps
  end)(),
  keys = {
    {
      '<leader>sf',
      function()
        require('telescope.builtin').find_files()
      end,
      desc = '[S]earch [F]ile',
    },
    {
      '<leader>sh',
      function()
        require('telescope.builtin').help_tags()
      end,
      desc = '[S]earch [H]elp',
    },
    {
      '<leader>sr',
      function()
        require('telescope.builtin').registers()
      end,
      desc = '[S]earch [R]egister',
    },
    {
      '<leader>sb',
      function()
        require('telescope.builtin').buffers()
      end,
      desc = '[S]earch [B]uffer',
    },
    {
      '<leader>ss',
      function()
        require('telescope.builtin').grep_string()
      end,
      desc = '[S]earch [S]tring',
    },
    {
      '<leader>sk',
      function()
        require('telescope.builtin').keymaps()
      end,
      desc = '[S]earch [K]eymap',
    },
    { '<leader>st', '<cmd>Telescope<cr>', desc = '[S]earch [T]elescope builtin' },
    {
      '<leader>sg',
      function()
        require('telescope').extensions.live_grep_args.live_grep_args()
      end,
      desc = '[S]earch [G]rep',
    },
    {
      '<leader>sp',
      function()
        require('telescope').extensions.project.project()
      end,
      desc = '[S]earch [P]roject',
    },
  },

  cmd = { 'Telescope' },

  opts = function(_, opts)
    local lga_actions = require 'telescope-live-grep-args.actions'
    return {
      defaults = {
        prompt_prefix = '   ',
        selection_caret = '  ',
        entry_prefix = '  ',
        initial_mode = 'normal',
      },
      pickers = {
        buffers = { theme = 'dropdown' },
        registers = { theme = 'dropdown' },
      },
      extensions = {
        -- project = {
        --   base_dirs = { '~/.config/nvim' },
        --   theme = 'dropdown',
        -- },
        live_grep_args = {
          auto_quoting = true,
          mappings = {
            i = {
              ['<C-k>'] = lga_actions.quote_prompt(),
              ['<C-i>'] = lga_actions.quote_prompt { postfix = ' --iglob ' },
            },
          },
        },
      },
    }
  end,
  config = function(_, opts)
    opts.extensions = { ['ui-select'] = { require('telescope.themes').get_dropdown() } }
    require('telescope').setup(opts)

    require('telescope').load_extension 'project'
    require('telescope').load_extension 'ui-select'
    require('telescope').load_extension 'live_grep_args'

    -- Those two might no always be there
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'harpoon')
    pcall(require('telescope').load_extension, 'notify')
    pcall(require('telescope').load_extension, 'todo-comments')
  end,
}
