local dap = require 'dap'

local cppdbg = require 'fymyte.tools.dap.cpptools'

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

dap.adapters.cppdbg = cppdbg.adapter

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
  {
    name = 'Debug Zephyr hello',
    type = 'cppdbg',
    request = 'launch',
    MIMode = 'gdb',
    miDebuggerServerAddress = 'localhost:3333',
    miDebuggerPath = 'nds32le-elf-gdb',
    cwd = '${workspaceFolder}',
    program = vim.env.HOME .. '/dev/sqn/sqn-sdk/zephyr/build-hello/zephyr/zephyr.elf',
    -- program = 'zephyr.elf',
    setupCommands = {
      -- { text = '-enable-pretty-printting', description = 'Enable pretty printting', ignoreFailures = false },
    },
  },
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.asm = dap.configurations.cpp
