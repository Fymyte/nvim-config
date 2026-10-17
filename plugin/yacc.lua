vim.pack.add {Utils.gh 'Fymyte/yacc.nvim'}

require('yacc').setup {
  -- Auto mode needs a model that supports it, the CLI falls back to default otherwise
  permission_mode = 'auto',
  suggestions = true,
  keys = { toggle = '<M-o>' },
}

vim.keymap.set('n', '<leader>to', '<cmd>CCToggle<cr>', { desc = '[T]oggle Claude' })
