vim.pack.add { Utils.gh 'coder/claudecode.nvim' }

require('claudecode').setup {}

vim.keymap.set('n', '<leader>to', '<cmd>ClaudeCode<cr>', { desc = '[T]oggle [C]laude' })
vim.keymap.set({ 'n', 't' }, '<M-o>', '<cmd>ClaudeCode<cr>', { desc = 'Toggle Claude' })
