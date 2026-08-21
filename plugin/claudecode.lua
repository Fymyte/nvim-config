-- Load snacks here as it is a dependency of claudecode for better terminal integration.
-- No need to configure snacks first, juste make sure packadd  run for snacks so
-- claudecode can require it.
vim.pack.add {
  Utils.gh 'folke/snacks.nvim',
  Utils.gh 'coder/claudecode.nvim',
}

require('claudecode').setup {
  -- Tagged into the Claude terminal's process env, so every child (including the `nvim`
  -- Claude spawns as its editor) inherits it. This is how plugin/flatten.lua tells a
  -- Claude-spawned guest from one started in a plain shell.
  env = { NVIM_CLAUDE_TERM = '1' },
  terminal = { split_width_percentage = .4 },
  diff_opts = {
    open_in_new_tab = true,
  },
}

vim.keymap.set('n', '<leader>to', '<cmd>ClaudeCode<cr>', { desc = '[T]oggle [C]laude' })
vim.keymap.set({ 'n', 't' }, '<M-o>', '<cmd>ClaudeCode<cr>', { desc = 'Toggle Claude' })
