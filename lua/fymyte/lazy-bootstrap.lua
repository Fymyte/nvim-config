local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

-- Clone lazy
if not vim.uv.fs_stat(lazypath) then
  print '=================================='
  print '    Lazy is being downloaded'
  print '     Wait until lazy finish'
  print '=================================='

  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end

vim.opt.rtp:prepend(lazypath)

return {
  dev = { path = '~/Documents/dev/' },
  install = { colorscheme = { 'catppuccin' } },
  change_detection = { enabled = true, notify = false },
}
