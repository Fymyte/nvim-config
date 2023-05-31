return {
  {
    'nvim-lua/plenary.nvim',
    config = function()
      require('plenary.filetype').add_file 'dts'
    end,
  },
  -- {
  --   'https://git.sr.ht/~soywod/himalaya-vim',
  -- },
}
