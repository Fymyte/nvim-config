vim.pack.add { Utils.gh 'mbbill/undotree' }

vim.keymap.set('n', '<F5>', vim.cmd.UndotreeToggle, { desc = 'Toggle undo tree' })
vim.keymap.set('n', '<leader>tu', vim.cmd.UndotreeToggle, { desc = '[T]oggle [U]ndo tree' })
