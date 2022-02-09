# My Neovim config

Architecture of config files are similar to [@tjdevries](https://github.com/tjdevries)
Plugins are managed using [packer.nvim](https://github.com/wbthomason/packer.nvim).

Much of the configuration can be found in either:

./after/plugin/*
  This is where configuration for most plugins is located.
  Configurations are sourced automatically at startup
  Some configuration are still left but associated plugins are no more installed

./plugin/*.lua
  This is where config for vim default options live.
  - options
  - keymaps
  - diagnostics

./lua/user/*.lua
  This is where added functionalities are located.
  Utils functions, or plugins extensions are also in this directory

- Theme: [kanagawa.nvim](https://github.com/rebelot/kanagawa.nvim)
- Status line: [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)
- Syntax highlight: [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- Completions: [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
- Fuzzy finder: [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
