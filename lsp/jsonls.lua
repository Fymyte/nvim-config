local ok, schemastore = pcall(require, 'schemastore')
local schemas = ok and schemastore.json.schemas() or {}

---@type vim.lsp.Config
return {
  cmd = { 'vscode-json-languageserver', '--stdio' },
  filetypes = { 'json', 'jsonc' },
  init_options = {
    provideFormatter = true,
  },
  root_markers = { '.git' },

  settings = {
    json = {
      schemas = schemas,
      validate = { enable = true },
    },
  },
}
