if not require'catppuccin' then
  return
end

vim.g.catppuccin_flavour = 'frappe'

require'catppuccin'.setup {

}
vim.cmd[[colo catppuccin]]
