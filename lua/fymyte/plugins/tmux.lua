---@type LazyPluginSpec
return {
  'aserowy/tmux.nvim',
  event = 'VeryLazy',
  opts = {
    navigation = {
      cycle_navigation = false,
      enable_default_keybindings = false,
    },
    resize = {
      enable_default_keybindings = false,
    },

    copy_sync = {
      enable = true,
      -- redirect_to_clipboard = true,
      sync_clipboard = false,
    },
  },
  config = function(_, opts)
    require('tmux').setup(opts)

    -- If this pluging is available, override default window navigation
    vim.keymap.set('n', '<C-w>l', require('tmux').move_right, { silent = true, noremap = true })
    vim.keymap.set('n', '<C-w><C-l>', require('tmux').move_right, { silent = true, noremap = true })
    vim.keymap.set('n', '<C-w>h', require('tmux').move_left, { silent = true, noremap = true })
    vim.keymap.set('n', '<C-w><C-h>', require('tmux').move_left, { silent = true, noremap = true })
    vim.keymap.set('n', '<C-w>k', require('tmux').move_top, { silent = true, noremap = true })
    vim.keymap.set('n', '<C-w><C-k>', require('tmux').move_top, { silent = true, noremap = true })
    vim.keymap.set('n', '<C-w>j', require('tmux').move_bottom, { silent = true, noremap = true })
    vim.keymap.set('n', '<C-w><C-j>', require('tmux').move_bottom, { silent = true, noremap = true })
  end,
}
