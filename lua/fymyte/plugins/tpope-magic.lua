---@type LazyPluginSpec
return {
  -- Surround textobjects with pairs
  'tpope/vim-surround',
  -- Allow repetition using `.`
  'tpope/vim-repeat',
  -- Operations on words
  'tpope/vim-abolish',
  -- ][ danse
  {
    'tpope/vim-unimpaired',
    event = 'VeryLazy',
    config = function(_, _)
      -- Make quickfix and location lists mapping loop
      vim.keymap.set('n', '[q', '<cmd>try | cprev | catch | clast | endtry<cr>', { noremap = true })
      vim.keymap.set('n', ']q', '<cmd>try | cnext | catch | cfirst| endtry<cr>', { noremap = true })
      vim.keymap.set('n', '[l', '<cmd>try | lprev | catch | llast | endtry<cr>', { noremap = true })
      vim.keymap.set('n', ']l', '<cmd>try | lnext | catch | lfirst| endtry<cr>', { noremap = true })
    end,
  },
  -- Builtin basic shell commands
  'tpope/vim-eunuch',
}
