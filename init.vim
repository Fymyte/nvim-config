" set runtimepath^=~/.vim runtimepath+=~/.vim/after
" let &packpath = &runtimepath
" source ~/.vimrc

" Enable plugins
source ~/.config/nvim/plugins/plugins.vim
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

" Fix colors for lsp errors and warnings
highlight LspDiagnosticsDefaultError guifg=#e41b56
highlight LspDiagnosticsDefaultWarning guifg=#e3641c


