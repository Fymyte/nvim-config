return function()
  local rust_analyzer_cmd = { 'rustup', 'run', 'nightly', 'rust-analyzer' }
  local extension_path = vim.fn.stdpath 'data' .. '/mason/packages/codelldb/extension'
  local codelldb_path = extension_path .. '/adapter/codelldb'
  local liblldb_path = extension_path .. '/lldb/lib/liblldb.so'

  require('rust-tools').setup {
    server = {
      -- `on_attach` and `capabilities` are set using default values
      cmd = rust_analyzer_cmd,
      settings = {
        ['rust-analyzer'] = {
          check = { command = 'clippy' },
          procMacro = { enabled = true },
        },
      },
    },
    dap = {
      adapter = require('rust-tools.dap').get_codelldb_adapter(codelldb_path, liblldb_path),
    },
  }
end
