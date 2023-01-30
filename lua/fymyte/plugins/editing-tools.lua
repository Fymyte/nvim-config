return  {
  -- Comment.nivm | Smart comments
  {
    'numtostr/comment.nvim', -- Smart comments
    opts = {
      -- Ignore empty lines when commenting (could be a function too)
      ignore = '^$',
      toggler = {
        line = 'gcc',
        block = 'gbc',
      },
      opleader = {
        line = 'gc',
        block = 'gb',
      },
      extra = {
        above = 'gcO', -- Add comment on the line above
        below = 'gco', -- Add comment on the line below
        eol = 'gcA', -- Add comment at the end of line
      },
    },
  },

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

  -- Automaticaly set tabstop/shiftwith (also use EditorConfig)
  'tpope/vim-sleuth',

  -- Git on steroids
  'tpope/vim-fugitive',
  -- GitHub/GitLab in neovim
  { 'tpope/vim-rhubarb', enabled = false },
  -- Git hunks displayed inline
  { 'lewis6991/gitsigns.nvim', dependencies = 'nvim-lua/plenary.nvim' },

  -- Surround textobjects with pairs
  'tpope/vim-surround',
  -- Allow repetition using `.`
  'tpope/vim-repeat',
  -- Operations on words
  'tpope/vim-abolish',
  -- ][ danse
  'tpope/vim-unimpaired',

  -- Yank also to keyboard
  'ojroques/vim-oscyank',

  -- Easily align text on symbol
  'junegunn/vim-easy-align',

  -- Show an undotree window
  'mbbill/undotree',

}
