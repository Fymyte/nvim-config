local utils = require 'user.utils'

-------------------
-- Keymaps
-------------------

utils.map( { 'n', '<leader>w', '<cmd>w!<cr>' } ) -- save
-- Move between windows
utils.map( { '', '<C-h>', '<cmd>wincmd h<cr>' } )
utils.map( { '', '<C-j>', '<cmd>wincmd j<cr>' } ) -- Leave J-K for completion
utils.map( { '', '<C-k>', '<cmd>wincmd k<cr>' } )
utils.map( { '', '<C-l>', '<cmd>wincmd l<cr>' } )
-- Move lines
utils.map( { 'n', '<M-j>', [[mz:m+<cr>`z]] } )
utils.map( { 'n', '<M-k>', [[mz:m-2<cr>`z]] } )
utils.map( { 'v', '<M-j>', [[:m'>+<cr>`<my`>mzgv`yo`z]] } )
utils.map( { 'v', '<M-k>', [[:m'<-2<cr>`>my`<mzgv`yo`z]] } )
-- Join line above at the end of the current line
utils.map( { 'n', '<leader>j', [[:m-2|j<cr>]] } )
-- Motions
utils.map( { 'n', '0', '^'}) -- use 0 to go to first char of line
utils.map( { 'n', '=', '+'})
-- Term
utils.map( { 't', '<Esc>', '<C-\\><C-n>' } )
-- Misc
utils.map( { '', '<leader>l', '<cmd>SidebarNvimToggle<cr>' } )
utils.map( { '', '<leader><Space>', '<cmd>noh<cr>' } )
