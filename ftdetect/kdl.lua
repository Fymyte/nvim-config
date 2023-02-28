-- ftdetect/kdl.lua

print("sourcing kdl.lua")
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = { '*.kdl' },
  group = vim.api.nvim_create_augroup('kdl-ftdetect', { clear = true }),
  callback = function()
    vim.bo.filetype = 'kdl'
  end,
})
