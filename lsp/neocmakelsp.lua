---@type vim.lsp.Config
return {
  cmd = { 'neocmakelsp', '--stdio' },
  filetypes = { 'cmake' },
  root_markers = {
    '.git',
    'build',
    'cmake',
  },

  capabilities = vim.tbl_deep_extend('force', vim.lsp.protocol.make_client_capabilities(), {
    textDocument = {
      completion = {
        completionItem = {
          snippetSupport = true,
        },
      },
    },
  }),

  init_options = {
    format = { enable = true },
    lint = { enable = true },
    scan_cmake_in_package = true,
    semantic_token = true,
  },
}
