vim.pack.add { Utils.gh 'akinsho/toggleterm.nvim' }

require('toggleterm').setup {
  size = function(term)
    if term.direction == 'horizontal' then
      return 15
    elseif term.direction == 'vertical' then
      return vim.o.columns * 0.4
    elseif term.direction == 'float' then
    end
    return vim.o.columns * 0.7
  end,
  open_mapping = { '<M-i>' },
  insert_mappings = false,
  shading_factor = -20,
  direction = 'vertical',
  shell = 'fish',
}

vim.keymap.set('n', '<leader>tt', require('toggleterm').toggle, { desc = '[T]oggle [T]erminal' })
vim.keymap.set('n', '<M-i>', require('toggleterm').toggle, { desc = '[T]oggle [T]erminal' })
