local default_config = require('lspconfig').util.default_config

return {
  settings = {
    ['nil'] = { nix = { flake = { autoEvalInputs = false } } },
  },

  on_attach = function(client, _)
    default_config.on_attach()
    -- Dont use semantic tockens for nil: use nixd for this
    client.server_capabilities.semanticTokensProvider = nil
  end,
}
