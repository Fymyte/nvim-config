local M = {}


--- @type dap.Adapter
M.adapter = {
  id = 'cppdbg',
  type = 'executable',
  command = vim.env.HOME .. '/.local/share/nvim/mason/bin/OpenDebugAD7',
}

return M
