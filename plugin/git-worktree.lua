vim.pack.add { Utils.gh 'Juksuu/worktrees.nvim' }

-- Needed to setup Snacks picker
require('worktrees').setup()
vim.keymap.set(
  'n',
  '<leader>sw',
  -- Do not use Snacks directly as it might not be loaded yet
  function() Snacks.picker.worktrees() end,
  { noremap = true, silent = true, desc = '[S]witch Git [W]orktrees' }
)
