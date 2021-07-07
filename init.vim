" set runtimepath^=~/.vim runtimepath+=~/.vim/after
" let &packpath = &runtimepath
" source ~/.vimrc

" Enable plugins
source ~/.config/nvim/plugins/plugins.vim
" Keybindings
source ~/.config/nvim/configs/keybindings.vim
" Theming and status bar
source ~/.config/nvim/configs/visual.vim
" Functions and commands
source ~/.config/nvim/configs/functions.vim
" General configs (nvim variables preferences)
source ~/.config/nvim/configs/general.vim

let g:lsp_cxx_hl_log_file = '/tmp/vim-lsp-cxx-hl.log'

