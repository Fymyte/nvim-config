# My Neovim config

Package-manager: [vim.pack](https://github.com/neovim/neovim) (builtin)\
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
- Completion: [blink.cmp](https://github.com/saghen/blink.cmp.git) (better than the builtin)
- File explorer:
    - [oil.nvim](https://github.com/stevearc/oil.nvim.git) (edit filesystem as a vim buffer)
    - [oil-git.nvim](https://github.com/benomahony/oil-git.nvim.git) (Git status in oil)
- Snippets:
    - Engine: [LuaSnip](https://github.com/L3MON4D3/LuaSnip.git)
    - [friendly-snippets](https://github.com/rafamadriz/friendly-snippets.git) (Just a list of snippets)
- Git:
    - [vim-fugitive](https://github.com/tpope/vim-fugitive.git) (Best git helper. Straight-up)
    - [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim.git) (Show git status in sign column)
- LSP:
    - [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig.git) (List of server config)
    - [lsp-progress.nvim](https://github.com/linrongbin16/lsp-progress.nvim.git) (LSP progress in statusline)
    - [SchemaStore.nvim](https://github.com/b0o/SchemaStore.nvim.git) (JSON/YAML schema validation based on filename)
- Fuzzy finder: [snacks.nvim](https://github.com/folke/snacks.nvim.git) (picker, input, bigfile and more)
    - Extensions:
    - [worktrees.nvim](https://github.com/Juksuu/worktrees.nvim.git) (Git worktrees picker)
- Quality of life:
    - [mini.jump](https://github.com/nvim-mini/mini.jump.git) (Extends f/t/F/T jumps multi-line)
    - [mini.move](https://github.com/nvim-mini/mini.move.git) (Move text around with alignment)
    - [mini.align](https://github.com/nvim-mini/mini.align.git) (Easily align things)
    - [mini.ai](https://github.com/nvim-mini/mini.ai.git) (Additional text-objects)
    - [nvim-autopairs](https://github.com/windwp/nvim-autopairs.git) (Auto-pair brackets)
    - [mason.nvim](https://github.com/williamboman/mason.nvim.git) (Manage external tools)
    - [vim-surround](https://github.com/tpope/vim-surround.git) (Add/Remove/Change surrounding brackets)
    - [vim-abolish](https://github.com/tpope/vim-abolish.git) (Better search/replace with case matching)
    - [vim-repeat](https://github.com/tpope/vim-repeat.git) (Extend dot repeat)
    - [vim-eunuch](https://github.com/tpope/vim-eunuch.git) (Common bash commands in vim commands)
    - [vim-unimpaired](https://github.com/tpope/vim-unimpaired.git) (Add more ][ dance)
    - [undotree](https://github.com/mbbill/undotree.git) (Togglable vim undotree)
    - [nvim-colorizer.lua](https://github.com/catgoose/nvim-colorizer.lua.git) (Small colored dots next to color-codes)
    - [vim-exchange](https://github.com/tommcdo/vim-exchange.git) (Exchange two regions)
    - [conform.nvim](https://github.com/stevearc/conform.nvim.git) (Buffer formatting using external tools or LSP)
    - [nvim-lint](https://github.com/mfussenegger/nvim-lint.git) (Run linters on demand)
    - [todo-comments.nvim](https://github.com/folke/todo-comments.nvim.git) (Highlight and list TODO/NOTE/FIXME/XXX comments)
    - [quicker.nvim](https://github.com/stevearc/quicker.nvim.git) (Better quickfix and loclist)
    - [vim-matchup](https://github.com/andymass/vim-matchup.git) (Better % matching)
- UI:
    - [toggleterm](https://github.com/akinsho/toggleterm.nvim) (Floating terminal)
    - [nvim-treesitter-context](https://github.com/nvim-treesitter/nvim-treesitter-context.git) (Show
      namespace/function signature at the top of the buffer)
    - [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons.git) (Icons for filetypes)
    - [fidget.nvim](https://github.com/j-hui/fidget.nvim) (Notifications)
    - [render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim.git) (Render markdown in buffer)
- Syntax:
    - [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter.git) (Now just manage installed parsers)
- AI:
    - [claudecode.nvim](https://github.com/coder/claudecode.nvim.git) (Claude Code integration)
