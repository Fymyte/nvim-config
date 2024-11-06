local check_system_deps = require('fymyte.utils').check_system_deps
local system_deps = require('fymyte.utils').system_deps

return {
  --------------------------------
  ----- Editor configuration -----
  --------------------------------

  -- Securly source local nvim config
  'klen/nvim-config-local',

  -------------------------------------
  ----- Textobjects and movements -----
  -------------------------------------

  -- Add a tone of textobjects
  'wellle/targets.vim',
  -- Easily move selection around
  {
    'echasnovski/mini.move',
    event = 'VeryLazy',
    version = false,
    config = function(_, opts)
      require('mini.move').setup(opts)
    end,
  },
  -- Smarter jumping to searched character
  {
    'echasnovski/mini.jump',
    enabled = false,
    event = 'VeryLazy',
    version = false,
    opts = { delay = { idle_stop = 2000 } },
    config = function(_, opts)
      require('mini.jump').setup(opts)
    end,
  },
  -- Automaticaly close matching pairs
  {
    'echasnovski/mini.pairs',
    event = 'VeryLazy',
    version = false,
    opts = {

    },
    config = function(_, opts)
      require('mini.pairs').setup(opts)
    end,
  },
  -- Surround textobjects with pairs
  'tpope/vim-surround',
  -- Allow repetition using `.`
  'tpope/vim-repeat',
  -- Operations on words
  'tpope/vim-abolish',
  -- ][ danse
  { 'tpope/vim-unimpaired', event = 'VeryLazy' },
  {
    'windwp/nvim-autopairs',
    enabled = false,
    opts = { check_ts = true },
    dependencies = { 'hrsh7th/nvim-cmp' },
    config = function(_, opts)
      local npairs = require 'nvim-autopairs'
      npairs.setup(opts)
      local cmp = require 'cmp'
      local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
      local rule = require 'nvim-autopairs.rule'
    end,
  },
  -- Exchange two zones of text
  {
    'tommcdo/vim-exchange',
    keys = { 'cx' },
  },
  -- Yank also to keyboard
  {
    'ojroques/vim-oscyank',
    event = 'VeryLazy',
    config = function()
      local autocmd = require('fymyte.utils').autocmd
      local augroup = require('fymyte.utils').augroup

      autocmd('TextYankPost', {
        group = augroup 'OSCYank',
        desc = 'automaticaly copy the content of yanked text in the keyboard',
        pattern = '*',
        callback = function()
          local event = vim.v.event
          if event.operator == 'y' and event.regname == '' then
            vim.cmd [[OSCYankRegister "]]
          end
        end,
      })
    end,
  },
  -- Easily align text on symbol
  {
    'junegunn/vim-easy-align',
    event = 'VeryLazy',
    keys = {
      { 'ga', '<Plug>(EasyAlign)', mode = { 'n', 'x' } },
    },
  },

  {
    'ThePrimeagen/harpoon',
    keys = {
      {
        '<leader>a',
        function()
          require('harpoon.mark').add_file()
        end,
        desc = '[A]dd harpoon mark',
      },
      {
        '<leader>sa',
        function()
          require('telescope').extensions.harpoon.marks()
        end,
        desc = '[S]earch h[A]rpoon mark',
      },
      {
        '<leader>1',
        function()
          require('harpoon.ui').nav_file(1)
        end,
        desc = 'Harpoon go to file 1',
      },
      {
        '<leader>2',
        function()
          require('harpoon.ui').nav_file(2)
        end,
        desc = 'Harpoon go to file 2',
      },
      {
        '<leader>3',
        function()
          require('harpoon.ui').nav_file(3)
        end,
        desc = 'Harpoon go to file 3',
      },
      {
        '<leader>4',
        function()
          require('harpoon.ui').nav_file(4)
        end,
        desc = 'Harpoon go to file 4',
      },
      {
        '<leader>5',
        function()
          require('harpoon.ui').nav_file(5)
        end,
        desc = 'Harpoon go to file 5',
      },
      {
        '<leader>6',
        function()
          require('harpoon.ui').nav_file(6)
        end,
        desc = 'Harpoon go to file 6',
      },
      {
        '<leader>7',
        function()
          require('harpoon.ui').nav_file(7)
        end,
        desc = 'Harpoon go to file 7',
      },
      {
        '<leader>8',
        function()
          require('harpoon.ui').nav_file(8)
        end,
        desc = 'Harpoon go to file 8',
      },
      {
        '<leader>9',
        function()
          require('harpoon.ui').nav_file(9)
        end,
        desc = 'Harpoon go to file 9',
      },
    },
  },

  -----------------------
  ----- Fuzy finder -----
  -----------------------

  {
    'nvim-telescope/telescope.nvim',
    build = function()
      check_system_deps({ 'fd', 'rg' }, 'telescope')
    end,
    dependencies = (function()
      local telescope_deps = {
        'nvim-telescope/telescope-file-browser.nvim',
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
      {
        '<leader>fb',
        function()
          require('telescope').extensions.file_browser.file_browser()
        end,
        desc = '[F]ile [B]rowser',
      },
    },
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
          project = {
            base_dirs = { '~/.config/nvim' },
            theme = 'dropdown',
          },
          file_browser = { theme = 'dropdown' },
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

      require('telescope').load_extension 'notify'
      require('telescope').load_extension 'file_browser'
      require('telescope').load_extension 'project'
      require('telescope').load_extension 'ui-select'
      require('telescope').load_extension 'todo-comments'
      require('telescope').load_extension 'live_grep_args'

      -- Those two might no always be there
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'harpoon')
      pcall(require('telescope').load_extension, 'himalaya')
    end,
  },

  --------------------
  ----- Comments -----
  --------------------

  -- Smart comments
  {
    'numtostr/comment.nvim', -- Smart comments
    opts = { ignore = '^$' },
  },
  -- Search/Beautify todo comments
  {
    'folke/todo-comments.nvim',
    opts = {
      highlight = { pattern = [[.*<(KEYWORDS)\s*(\([^)]+\))?:]] },
      search = { pattern = [[\b(KEYWORDS)(\([^)]*\))?:]] },
    },
  },
}
