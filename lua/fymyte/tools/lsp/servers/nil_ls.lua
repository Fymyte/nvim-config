return function(default_config)
  require('lspconfig')['nil_ls'].setup {
    settings = {
      ['nil'] = { nix = { flake = { autoEvalInputs = false } } },
    },

    on_attach = function(client, bufnr)
      default_config.on_attach(client, bufnr)
      -- Dont use semantic tockens for nil: use nixd for this
      client.server_capabilities.semanticTokensProvider = nil
    end,
  }
end
