local augroup = require('fymyte.utils').augroup
local autocmd = vim.api.nvim_create_autocmd

-- Automatically enable treesitter highlighting when opening a file
autocmd('FileType', {
  group = augroup 'tree-sitter-highlight',
  callback = function(args)
    pcall(vim.treesitter.start, args.buf)
  end,
})
