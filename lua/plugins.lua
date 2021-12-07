-- spellchecker: disable
local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/autoload/plugged')
-- """"""""""""""""""""""""
-- " Utils
-- """"""""""""""""""""""""
-- add icons before files and folders
  Plug 'ryanoasis/vim-devicons'
-- file explorer
  Plug 'scrooloose/nerdtree'
-- edit same text in multiple files (also subfolders)
  Plug 'dyng/ctrlsf.vim'
-- git commands inside vim
--  Plug 'tpope/vim-fugitive'
-- Format c/cpp using clang format
-- "  Plug 'rhysd/vim-clang-format'
-- Easier commenting using keybindings
  Plug 'preservim/nerdcommenter'
-- Snippets support
  Plug 'hrsh7th/cmp-vsnip'
  Plug 'hrsh7th/vim-vsnip'
--  " Fuzzy search
--  " Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'
-- copy/paste everywhere
  Plug 'ojroques/vim-oscyank'
  Plug 'rcarriga/nvim-notify'

--""""""""""""""""""""""""
--" Highlighting and LSP
--""""""""""""""""""""""""
--  " Highlighting with treesitter
  Plug('nvim-treesitter/nvim-treesitter', { ['do'] = 'TSUpdate' })
-- Neovin integrated lsp client
  Plug 'neovim/nvim-lspconfig'
--  " Install lsp sever for many language
  Plug 'williamboman/nvim-lsp-installer'
-- LSP based Autocompletion with more sources
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/cmp-nvim-lua'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'f3fora/cmp-spell' -- spellchecking
-- additional hint for rust
  Plug 'simrat39/rust-tools.nvim'

--""""""""""""""""""""""""
--" Language supports
--""""""""""""""""""""""""
--  " Auto pairs for '(' '[' '{'
  Plug 'jiangmiao/auto-pairs'
-- " heptagon
-- "  Plug 'Fymyte/hept.vim'
-- GNU AS
--"  Plug 'shirk/vim-gas'
  Plug 'igankevich/mesonic'
--  Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
--  "Plug 'thindil/Ada-Bundle's
-- i3 config
  Plug 'moon-musick/vim-i3-config-syntax'
-- rofi config
-- Plug 'cantoromc/vim-rasi'
-- kitty config
  Plug 'fladson/vim-kitty'

--""""""""""""""""""""""""
--" Visual
--""""""""""""""""""""""""
-- color background for rbg, hex and anssi colors
  Plug 'ap/vim-css-color'
-- more icons for lsp doc
  Plug 'onsails/lspkind-nvim'
-- Material colorscheme for vim
  Plug ('kaicataldo/material.vim', { branch = 'main' })
-- better status line
  Plug 'nvim-lualine/lualine.nvim'
--  Plug 'itchyny/lightline.vim'
-- better vim startup screen
  Plug 'mhinz/vim-startify'
  Plug 'dstein64/vim-startuptime'

vim.call('plug#end')
