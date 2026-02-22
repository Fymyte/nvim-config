---@type vim.lsp.Config
return {
  settings = {
    ['nil'] = {
      nix = {
        -- maxMemoryMB = 0,
        flake = { autoArchive = true, autoEvalInputs = true },
      },
    },
  },
}
