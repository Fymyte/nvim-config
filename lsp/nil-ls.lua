local global_attach = require('fymyte.lsp').on_attach

---@type vim.lsp.Config
return {
  cmd = { 'nil' },
  filetypes = { 'nix' },
  root_markers = {
    '.git',
    'flake.nix',
  },
  on_attach = function(client, bufnr)
    global_attach(client, bufnr)

    -- Don't use semantic tokens for nil: use nixd for this
    -- client.server_capabilities.semanticTokensProvider = nil
  end,

  settings = {
    ['nil'] = { nix = { maxMemoryMB = 8192, flake = { autoEvalInputs = true } } },
  },
}
