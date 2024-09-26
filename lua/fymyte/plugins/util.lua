return {
  {
    'nvim-lua/plenary.nvim',
    config = function()
      require('plenary.filetype').add_file 'dts'
    end,
  },
  {
    'pimalaya/himalaya-vim',
    -- Use cond instead of enabled to have it as soon as himalaya is installed
    cond = function()
      return vim.fn.executable 'himalaya' == 1
    end,
  },
}
