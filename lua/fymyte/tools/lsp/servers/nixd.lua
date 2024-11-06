return {
  cmd = { 'nixd', '--inlay-hints=true'},
  settings = {
    nixd = {
      nixpkgs = { expr = 'import <nixpkgs> {}' },
      options = {
        nixos = {
          expr = '(builtins.getFlake ("git+file://" + toString ./.)).nixosConfigurations.k-on.options',
        },
        home_manager = {
          expr = '(builtins.getFlake ("git+file://" + toString ./.)).homeConfigurations."ruixi@k-on".options',
        },
      },
    },
  },
}
