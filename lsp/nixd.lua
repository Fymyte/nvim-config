---@type vim.lsp.Config
return {
  cmd = { 'nixd', '--inlay-hints=true' },
  filetypes = { 'nix' },
  root_markers = {
    '.git',
    'flake.nix',
  },

  settings = {
    nixd = {
      nixpkgs = { expr = '(builtins.getFlake ("git+file://" + toString ./.)).inputs.nixpkgs' },
      options = {
        nixos = {
          expr = '(builtins.getFlake ("git+file://" + toString ./.)).nixosConfigurations.snorlax.options',
        },
        home_manager = {
          expr = '(builtins.getFlake ("git+file://" + toString ./.)).homeConfigurations."pguillaume@snorlax".options',
        },
      },
    },
  },
}
