local ok, schemastore = pcall(require, 'schemastore')
local schemas = ok and schemastore.yaml.schemas() or {}

---@type vim.lsp.Config
return {
  settings = {
    yaml = {
      schemaStore = { enable = false, url = '' },
      schemas = schemas,

      customTags = { "!reference sequence"}
    },
  },
}
