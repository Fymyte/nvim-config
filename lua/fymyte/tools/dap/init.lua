local dap = require 'dap'

vim.fn.sign_define('DapBreakpoint', {
  text = '🛑',
  texthl = '',
  linehl = '',
  numhl = '',
})

dap.adapters.codelldb = {
  type = 'server',
  port = '${port}',
  executable = {
    -- CHANGE THIS to your path!
    command = 'codelldb',
    args = { '--port', '${port}' },
  },
}

dap.configurations.cpp = {
  {
    name = 'Launch file',
    type = 'codelldb',
    request = 'launch',
    program = function()
      return coroutine.create(function(coro)
        vim.ui.input({
          prompt = 'Path to executable: ',
          default = vim.fn.getcwd() .. '/',
          completion = 'file',
        }, function(file)
          coroutine.resume(coro, file)
        end)
      end)
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  },
}
dap.configurations.c = dap.configurations.cpp
