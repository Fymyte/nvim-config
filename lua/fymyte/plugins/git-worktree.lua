---@type LazyPluginSpec
return {
  'Juksuu/worktrees.nvim',
  dependencies = {'snacks.nvim'},
  config = function()
    -- Needed to setup Snacks picker
    require('worktrees').setup()
    vim.keymap.set(
      'n',
      '<leader>sw',
      Snacks.picker.worktrees,
      { noremap = true, silent = true, desc = '[S]witch Git [W]orktrees' }
    )
  end,
}
