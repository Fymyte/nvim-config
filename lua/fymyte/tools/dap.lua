local dap = require'dap'

local opts = { noremap = true, silent = true }

local repeat_helper = function(command)
  return function()
    vim.cmd('silent! call repeat#set("@@", v:count)')
    vim.cmd(":" .. command)
  end
end
vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, opts)
vim.keymap.set('n', '<leader>do', repeat_helper'DapStepOver', opts)
vim.keymap.set('n', '<leader>di', repeat_helper'DapStepInto', opts)
vim.keymap.set('n', '<leader>dc', repeat_helper'DapContinue', opts)

local dapui = require'dapui'
dapui.setup()

vim.keymap.set('n', '<leader>dd', dapui.toggle, opts)
