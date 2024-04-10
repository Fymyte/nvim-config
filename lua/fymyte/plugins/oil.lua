require'oil'.setup({
  columns = {
    'size',
    'icon',
  },
})

vim.keymap.set('n', '<leader>o', require('oil').open, {
  silent = true,
  desc = "[O]il open current file's directory",
})
