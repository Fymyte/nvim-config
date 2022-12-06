local has_fterm, fterm = pcall(require, 'FTerm')
if not has_fterm then
  return
end

fterm.setup {
  border = 'rounded',
}

vim.keymap.set('n', '<A-i>', require("FTerm").toggle)
vim.keymap.set('t', '<A-i>', '<C-\\><C-n><cmd>lua require("FTerm").toggle()<CR>')
