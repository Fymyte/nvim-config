if not pcall(require, 'dressing') then
  return
end

require'dressing'.setup {
  input = {
    insert_only = false,
  },
}
