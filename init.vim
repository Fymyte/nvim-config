" set runtimepath^=~/.vim runtimepath+=~/.vim/after
" let &packpath = &runtimepath
" source ~/.vimrc

" This needs to be placed before loading of plugins
let g:ale_disable_lsp = 1
" Enable plugins
source ~/.config/nvim/plugins/plugins.vim
" Plugins keybindings
"source ~/.config/nvim/configs/plugins_keybindings.vim
" Keybindings
source ~/.config/nvim/configs/treesitter.vim
source ~/.config/nvim/configs/nvimlsp.vim
source ~/.config/nvim/configs/keybindings.vim
" Theming and status bar
source ~/.config/nvim/configs/visual.vim
" Functions and commands
source ~/.config/nvim/configs/functions.vim
" General configs (nvim variables preferences)
source ~/.config/nvim/configs/general.vim

