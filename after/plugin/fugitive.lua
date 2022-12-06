vim.api.nvim_create_autocmd('BufReadPost', {
  pattern = 'fugitive://*',
  callback = function()
    vim.b.bufhidden = 'delete'
  end,
})
