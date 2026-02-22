local ok, schemastore = pcall(require, 'schemastore')
local schemas = ok and schemastore.json.schemas() or {}

---@type vim.lsp.Config
return {
  settings = {
    json = {
      schemas = schemas,
      validate = { enable = true },
    },
  },
}
