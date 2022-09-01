if not pcall(require, 'persistence') then
  return
end

require('persistence').setup {
  dir = vim.fn.expand(vim.fn.stdpath 'cache' .. '/sessions/'),
}

vim.api.nvim_create_autocmd('BufEnter', {
  group = vim.api.nvim_create_augroup('persistence-auto-save', { clear = true }),
  callback = function(args)
    if args.file and args.file ~= "" then
      require('persistence').save()
    end
  end,
})

if vim.fn.argc(-1) == 0 then
  -- We want to autoload the last session if no arguments are given
  require'persistence'.load()
end
