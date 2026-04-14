local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

vim.pack.add { Utils.gh 'mfussenegger/nvim-lint' }

require('lint').linters_by_ft = {
  lua = { 'selene' },
  fish = { 'fish' },
  sh = { 'shellcheck' },
}

autocmd({ 'BufWritePost' }, {
  group = augroup('auto-lint-on-save', { clear = true }),
  callback = function()
    require('lint').try_lint()
  end,
})
