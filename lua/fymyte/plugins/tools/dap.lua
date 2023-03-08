local repeat_helper = function(command)
  return function()
    vim.cmd 'silent! call repeat#set("@@", v:count)'
    vim.cmd(':' .. command)
  end
end

return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      { 'rcarriga/nvim-dap-ui', config = true },
    },
    keys = {
      {
        '<leader>tb',
        function()
          require('dap').toggle_breakpoint()
        end,
        desc = '[T]oggle [B]reakpoint',
      },
      {
        '<leader>td',
        function() require('dapui').toggle() end,
        desc = '[T]oggle [D]ebug',
      },
      {
        '<leader>ds',
        repeat_helper 'DapStepOver',
        desc = '[D]ebug [S]tep over',
      },
      {
        '<leader>di',
        repeat_helper 'DapStepInto',
        desc = '[D]ebug step [I]nto',
      },
      {
        '<leader>dc',
        repeat_helper 'DapContinue',
        desc = '[D]ebug [C]ontinue',
      },
    },
  },
}
