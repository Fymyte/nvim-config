-- Sorts after plugin/snacks.lua, so Snacks is set up when worktrees registers its pickers
vim.pack.add { Utils.gh 'Juksuu/worktrees.nvim' }

local fugitive = require 'fymyte.fugitive'

local reopen_status = false
require('worktrees').setup {
  switch_file_command = 'Oil',
  hooks = {
    -- worktrees.nvim wipes the file buffer, which closes its window, then opens the
    -- new file or Oil in the status window. Closing the status first keeps that window
    on_before_switch = function()
      reopen_status = fugitive.is_status_open()
      fugitive.close_status()
    end,
    on_switch = function()
      if reopen_status then
        local win = vim.api.nvim_get_current_win()
        fugitive.open_status()
        vim.api.nvim_set_current_win(win)
      end
    end,
  },
}

---@diagnostic disable-next-line:undefined-field
vim.keymap.set('n', '<leader>sw', Snacks.picker.worktrees, { desc = '[S]earch Git [W]orktrees' })
