return {
  cmd = { 'nixd', '--inlay-hints=true'},
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
