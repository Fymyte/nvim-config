vim.pack.add { Utils.gh 'stevearc/quicker.nvim' }

require('quicker').setup()
vim.keymap.set('n', '<leader>q', require('quicker').toggle, { desc = 'Toggle [Q]uickfix' })
vim.keymap.set('n', '<leader>l', function()
  require('quicker').toggle { loclist = true }
end, { desc = 'Toggle [L]oclist' })
vim.keymap.set('n', '>', function()
  require('quicker').expand { before = 2, after = 2, add_to_existing = true }
end, { desc = 'Expand quickfix context' })
vim.keymap.set('n', '<', function()
  require('quicker').collapse()
end, { desc = 'Collapse quickfix context' })
