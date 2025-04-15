local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

---@type LazyPluginSpec
return {
  'mfussenegger/nvim-lint',
  config = function(_, _)
    require('lint').linters_by_ft = {
      -- markdown = { 'vale' },
      -- c = { 'checkpatch' },
      -- cpp = { 'checkpatch' },
      lua = { 'selene' },
      fish = { 'fish' },
      sh = { 'shellcheck' },
    }

    table.insert(require('lint').linters.checkpatch.args, '--no-show-types')

    autocmd({ 'BufWritePost' }, {
      group = augroup('auto-lint-on-save', { clear = true }),
      callback = function()
        require('lint').try_lint()
      end,
    })
  end,
}
