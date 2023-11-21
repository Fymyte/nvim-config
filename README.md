# My Neovim config

I use [lazy.nvim](https://github.com/folke/lazy.nvim) as my package manager

## Nvim config no plugins
Config for nvim's default options lives in
- [options](./lua/fymyte/options.lua) vim `set option`
- [keymaps](./lua/fymyte/keymaps.lua) cutom key mappings
- [diagnostics](./lua/fymyte/diagnostics.lua) nvim diagnostics

## Plugins
- Colorscheme: [catppuccin](https://github.com/catppuccin/nvim.git)
- Statusline: [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim.git)
- Git:
    - [vim-fugitive](https://github.com/tpope/vim-fugitive.git)
    - [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim.git)
- LSP:
    - [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig.git)
    - [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim.git)
    - [mason.nvim](https://github.com/williamboman/mason.nvim.git)
    - [rust-tools.nvim](https://github.com/simrat39/rust-tools.nvim.git)
    - [clangd_extensions.nvim](https://github.com/p00f/clangd_extensions.nvim.git)
    - [ltex_extra.nvim](https://github.com/barreiroleo/ltex_extra.nvim.git)
    - [null-ls.nvim](https://github.com/jose-elias-alvarez/null-ls.nvim.git)
    - [lspkind-nvim](https://github.com/onsails/lspkind-nvim.git)
- Debugging: [nvim-dap](https://github.com/mfussenegger/nvim-dap.git)
    - [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui.git)
- Completion: [nvim-cmp](https://github.com/hrsh7th/nvim-cmp.git)
    - Sources:
    - [cmdline](https://github.com/hrsh7th/cmp-cmdline.git)
    - [nvim-lua](https://github.com/hrsh7th/cmp-nvim-lua.git)
    - [spell](https://github.com/f3fora/cmp-spell.git)
    - [git](https://github.com/petertriho/cmp-git.git)
    - [dap](https://github.com/rcarriga/cmp-dap.git)
    - [path](https://github.com/hrsh7th/cmp-path.git)
    - [buffer](https://github.com/hrsh7th/cmp-buffer.git)
    - [lsp](https://github.com/hrsh7th/cmp-nvim-lsp.git)
    - [lsp-signature-help](https://github.com/hrsh7th/cmp-nvim-lsp-signature-help.git)
    - [lsp-document-symbol](https://github.com/hrsh7th/cmp-nvim-lsp-document-symbol.git)
    - [luasnip](https://github.com/saadparwaiz1/cmp_luasnip.git)
- Snippet: [LuaSnip](https://github.com/L3MON4D3/LuaSnip.git)
- Fuzzy finder: [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim.git)
    - Extensions:
    - [telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim.git)
    - [telescope-file-browser.nvim](https://github.com/nvim-telescope/telescope-file-browser.nvim.git)
    - [telescope-live-grep-args.nvim](https://github.com/nvim-telescope/telescope-live-grep-args.nvim.git)
    - [telescope-project.nvim](https://github.com/nvim-telescope/telescope-project.nvim.git)
    - [telescope-ui-select.nvim](https://github.com/nvim-telescope/telescope-ui-select.nvim.git)
- Quality of life:
    - [mini.jump](https://github.com/echasnovski/mini.jump.git)
    - [mini.pairs](https://github.com/echasnovski/mini.pairs.git)
    - [mini.move](https://github.com/echasnovski/mini.move.git)
    - [vim-surround](https://github.com/tpope/vim-surround.git)
    - [targets.vim](https://github.com/wellle/targets.vim.git)
    - [vim-abolish](https://github.com/tpope/vim-abolish.git)
    - [comment.nvim](https://github.com/numtostr/comment.nvim.git)
    - [vim-repeat](https://github.com/tpope/vim-repeat.git)
    - [vim-eunuch](https://github.com/tpope/vim-eunuch.git)
    - [vim-unimpaired](https://github.com/tpope/vim-unimpaired.git)
    - [undotree](https://github.com/mbbill/undotree.git)
    - [nvim-colorizer.lua](https://github.com/NvChad/nvim-colorizer.lua.git)
    - [vim-exchange](https://github.com/tommcdo/vim-exchange.git)
    - [vim-easy-align](https://github.com/junegunn/vim-easy-align.git)
    - [neogen](https://github.com/danymat/neogen.git)
- UI:
    - [toggleterm](https://github.com/akinsho/toggleterm.nvim) floating terminal
    - [dressing.nvim](https://github.com/stevearc/dressing.nvim.git)
    - [nvim-notify](https://github.com/rcarriga/nvim-notify.git)
- Syntax:
    - [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter.git)
    - [mbsync.vim](https://github.com/Fymyte/mbsync.vim.git)
    - [rasi.vim](https://github.com/fymyte/rasi.vim.git)
- Note taking: [neorg](https://github.com/nvim-neorg/neorg.git)

