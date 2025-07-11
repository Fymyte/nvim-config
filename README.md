# My Neovim config

Package-manager: [lazy.nvim](https://github.com/folke/lazy.nvim)\
Colorscheme: [catppuccin](https://github.com/catppuccin/nvim.git) (mocha variant)

## Nvim configuration
- Builtin options: [lua/fymyte/options.lua](./lua/fymyte/options.lua)
- Custom keymaps: [lua/fymyte/keymaps.lua](./lua/fymyte/keymaps.lua) (Additional text objects or shortcuts for builtin vim
  functionality)
- Builtin diagnostics: [lua/fymyte/diagnostics.lu](./lua/fymyte/diagnostics.lua)
- Builtin lsp:
  - [Client](./lua/fymyte/lsp.lua)
  - [Servers](./lsp)
- Treesitter: [lua/fymyte/treesitter.lua](./lua/fymyte/treesitter.lua)

## Plugins
- Statusline: [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim.git)
- Completion: [blink.cmp](https://github.com/saghen/blink.cmp.git) (better than then builtin)
- File explorer: [oil.nvim](https://github.com/stevearc/oil.nvim.git) (edit filesystem as a vim buffer)
- Snippets:
    - Engine: [LuaSnip](https://github.com/L3MON4D3/LuaSnip.git)
    - [friendly-snippets](https://github.com/rafamadriz/friendly-snippets.git) (Just a list of snippet)
- Git:
    - [vim-fugitive](https://github.com/tpope/vim-fugitive.git) (Best git helper. Straigt-up)
    - [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim.git) (Show git status in sign column)
    - [git-worktree.nvim](https://github.com/polarmutex/git-worktree.nvim.git) (Easily switch between git worktrees)
- LSP:
    - [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig.git) (List of server config)
    - [lsp-progress.nvim](https://github.com/linrongbin16/lsp-progress.nvim.git) (LSP progress in statusline)
    - [SchemaStore.nvim](https://github.com/b0o/SchemaStore.nvim.git) (JSON/YAML schema validation based on filename)
- Fuzzy finder: [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim.git)
    - Extensions:
    - [telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim.git)
    - [telescope-file-browser.nvim](https://github.com/nvim-telescope/telescope-file-browser.nvim.git)
    - [telescope-live-grep-args.nvim](https://github.com/nvim-telescope/telescope-live-grep-args.nvim.git)
    - [telescope-project.nvim](https://github.com/nvim-telescope/telescope-project.nvim.git)
    - [telescope-ui-select.nvim](https://github.com/nvim-telescope/telescope-ui-select.nvim.git)
- Quality of life:
    - [mini.jump](https://github.com/echasnovski/mini.jump.git) (Extends f/t/F/T jumps multi-line)
    - [mini.move](https://github.com/echasnovski/mini.move.git) (Move text around with alignment)
    - [mini.align](https://github.com/echasnovski/mini.align.git) (Easily align things)
    - [mini.ai](https://github.com/echasnovski/mini.ai.git) (Additional text-objects)
    - [nvim-autopairs](https://github.com/windwp/nvim-autopairs.git) (Auto-pair brackets)
    - [harpoon](https://github.com/ThePrimeagen/harpoon.git) (Better alternate buffers)
    - [mason.nvim](https://github.com/williamboman/mason.nvim.git) (Manage external tools)
    - [vim-surround](https://github.com/tpope/vim-surround.git) (Add/Remove/Change surrounding brackets)
    - [vim-abolish](https://github.com/tpope/vim-abolish.git) (Better search/replace with case matching)
    - [comment.nvim](https://github.com/numtostr/comment.nvim.git) (Add/Remove comments on any languages with the same
      keymap)
    - [vim-repeat](https://github.com/tpope/vim-repeat.git) (Extand dot repeat)
    - [vim-eunuch](https://github.com/tpope/vim-eunuch.git) (Common bash commands in vim commands)
    - [vim-unimpaired](https://github.com/tpope/vim-unimpaired.git) (Add more ][ dance)
    - [undotree](https://github.com/mbbill/undotree.git) (Togglable vim undotree)
    - [nvim-colorizer.lua](https://github.com/NvChad/nvim-colorizer.lua.git) (Small colored dots next to color-codes)
    - [vim-exchange](https://github.com/tommcdo/vim-exchange.git) (Exchange two )
    - [conform.nvim](https://github.com/stevearc/conform.nvim.git) (Buffer formatting using external tools or LSP)
    - [nvim-lint](https://github.com/mfussenegger/nvim-lint.git) (Run linters on demand)
    - [tmux.nvim](https://github.com/aserowy/tmux.nvim.git) (Share keybindings between vim and tmux)
    - [todo-comments.nvim](https://github.com/folke/todo-comments.nvim.git) (Highlist and list TODO/NOTE/FIXME/XXX
      comments)
- UI:
    - [toggleterm](https://github.com/akinsho/toggleterm.nvim) (Floating terminal)
    - [dressing.nvim](https://github.com/stevearc/dressing.nvim.git) (Better vim.ui.open and vim.ui.select)
    - [nvim-treesitter-context](https://github.com/nvim-treesitter/nvim-treesitter-context.git) (Show
      namespace/function signature at the top of the buffer)
    - [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons.git) (Icons for filetypes)
    - [fidget.nvim](https://github.com/j-hui/fidget.nvim) (Small UI for notifications)
- Syntax:
    - [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter.git) (Now just manage installed parsers)
