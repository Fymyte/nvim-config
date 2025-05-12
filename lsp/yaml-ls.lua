local ok, schemastore = pcall(require, 'schemastore')
local schemas = ok and schemastore.yaml.schemas() or {}

---@type vim.lsp.Config
return {
  cmd = { 'yaml-language-server', '--stdio' },
  filetypes = { 'yaml', 'yaml.docker-compose', 'yaml.gitlab' },

  root_markers = { '.git' },

  settings = {
    yaml = {
      schemaStore = { enable = false, url = '' },
      schemas = schemas,

      customTags = { "!reference sequence"}
    },
  },
}
