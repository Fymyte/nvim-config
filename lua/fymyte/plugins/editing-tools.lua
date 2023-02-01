local check_system_deps = require'fymyte.utils'.check_system_deps
local system_deps = require'fymyte.utils'.system_deps

return  {
  --------------------------------
  ----- Editor configuration -----
  --------------------------------

  -- Automaticaly set tabstop/shiftwith (also use EditorConfig)
  'tpope/vim-sleuth',
  -- Load configuration from .editorconfig
  { 'gpanders/editorconfig.nvim', enabled = false },
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
    config = function(_, opts) require'mini.move'.setup(opts) end,
  },
  -- Smarter jumping to searched character
  {
    'echasnovski/mini.jump',
    event = 'VeryLazy',
    version = false,
    opts = { delay = { idle_stop = 1000 } },
    config = function(_, opts) require'mini.jump'.setup(opts) end,
  },
  -- Automaticaly close matching pairs
  {
    'echasnovski/mini.pairs',
    event = 'VeryLazy',
    version = false,
    config = function(_, opts) require'mini.pairs'.setup(opts) end,
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
      local npairs = require'nvim-autopairs'
      npairs.setup(opts)
      local cmp = require'cmp'
      local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
      local rule = require'nvim-autopairs.rule'
    end,
  },
  -- Exchange two zones of text
  {
    'tommcdo/vim-exchange',
    keys = { 'cx' },
  },
  -- Yank also to keyboard
  { 'ojroques/vim-oscyank', event = 'VeryLazy' },
  -- Easily align text on symbol
  { 'junegunn/vim-easy-align', event = 'VeryLazy' },


  -----------------------
  ----- Fuzy finder -----
  -----------------------

  {
    'nvim-telescope/telescope.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    build = function()
      check_system_deps({ 'fd', 'rg' }, 'telescope')
    end,
    dependencies = (function()
      local telescope_deps = {
        'nvim-telescope/telescope-file-browser.nvim',
        'nvim-telescope/telescope-project.nvim',
        'nvim-telescope/telescope-ui-select.nvim',
        'nvim-telescope/telescope-packer.nvim',
        'nvim-telescope/telescope-live-grep-args.nvim',
      }

      local missing_deps = system_deps('make', { 'gcc', 'clang' })
      if #missing_deps == 0 then
        table.insert(telescope_deps, { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' })
      else
        vim.notify('missing deps for fzf: ' .. vim.inspect(missing_deps), 'warn', { title = 'Telescope' })
      end

      return telescope_deps
    end)(),
    keys = {
      { '<leader>sf', function() require'telescope.builtin'.find_files() end, desc = '[S]earch [F]ile' },
      { '<leader>sh', function() require'telescope.builtin'.help_tags() end, desc = '[S]earch [H]elp' },
      { '<leader>sr', function() require'telescope.builtin'.registers() end, desc = '[S]earch [R]egister' },
      { '<leader>sb', function() require'telescope.builtin'.buffers() end, desc = '[S]earch [B]uffer' },
      { '<leader>ss', function() require'telescope.builtin'.grep_string() end, desc = '[S]earch [S]tring' },
      { '<leader>sk', function() require'telescope.builtin'.keymaps() end, desc = '[S]earch [K]eymap' },
      { '<leader>st', '<cmd>Telescope<cr>', desc = '[S]earch [T]elescope builtin' },
      { '<leader>sg', function() require'telescope'.extensions.live_grep_args.live_grep_args() end, desc = '[S]earch [G]rep' },
      { '<leader>sp', function() require'telescope'.extensions.project.project() end, desc = '[S]earch [P]roject' },
      { '<leader>fb', function() require'telescope'.extensions.file_browser.file_browser() end, desc = '[F]ile [B]rowser' },
    },
    opts = function (_, opts)
      local lga_actions = require'telescope-live-grep-args.actions'
      return {
        defaults = {
          prompt_prefix = '   ',
          selection_caret = "  ",
          entry_prefix = "  ",
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
          ['ui-select'] = { theme = 'dropdown' },
          live_grep_args = {
            auto_quoting = true,
            mappings = {
              i = {
                ["<C-k>"] = lga_actions.quote_prompt(),
                ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
              },
            }
          }
        },
      }
    end,
    config = function(_, opts)
      require'telescope'.setup(opts)

      require'telescope'.load_extension 'notify'
      require'telescope'.load_extension 'file_browser'
      require'telescope'.load_extension 'project'
      require'telescope'.load_extension 'ui-select'
      require'telescope'.load_extension 'todo-comments'
      require'telescope'.load_extension 'live_grep_args'

      if require'telescope._extensions.fzf' then
          require'telescope'.load_extension 'fzf'
      end
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


  ----------------
  ----- Misc -----
  ----------------

  -- Fterm.nvim | Floating terminal in nvim
  {
    'numtostr/fterm.nvim',
    opts = { border = 'rounded' },
    keys = {
      -- Add a wrapping function to work even when FTerm is not already installed
      { '<A-i>', function() require'FTerm'.toggle() end, desc = 'Floating terminal toggle' },
      { '<A-i>', '<C-\\><C-n><cmd>lua require("FTerm").toggle()<CR>', mode = 't', desc = 'Floating terminal toggle' },
    },
  },
  -- Show an undotree window
  {
    'mbbill/undotree',
    keys = {{ '<F5>', '<cmd>UndotreeToggle<cr>', desc = 'Toggle undo tree' }},
    cmd = 'UntotreeToggle',
  },
}
