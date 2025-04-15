---@type LazyPluginSpec
return {
  'polarmutex/git-worktree.nvim',
  dependencies = { 'nvim-telescope/telescope.nvim' },
  keys = { '<leader>sw' },
  config = function(_, _)
    local hooks = require 'git-worktree.hooks'
    local config = require 'git-worktree.config'

    require('telescope').load_extension 'git_worktree'
    vim.keymap.set(
      'n',
      '<leader>sw',
      require('telescope').extensions.git_worktree.git_worktree,
      { noremap = true, silent = true, desc = '[S]earch Git [W]orktree' }
    )

    hooks.register(hooks.type.SWITCH, hooks.builtins.update_current_buffer_on_switch)
    hooks.register(hooks.type.DELETE, config.update_on_change_command)
  end,
}
