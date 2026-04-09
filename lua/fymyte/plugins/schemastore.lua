---@type LazyPluginSpec
return {
  'b0o/SchemaStore.nvim',
  config = function()
    vim.lsp.config('jsonls', {
      settings = {
        json = {
          schemas = require('schemastore').json.schemas(),
          validate = { enable = true },
        },
      },
    })

    vim.lsp.config('yaml-ls', {

      settings = {
        yaml = {
          schemaStore = { enable = false, url = '' },
          schemas = require('schemastore').yaml.schemas(),
          customTags = { '!reference sequence' },
        },
      },
    })
  end,
}
