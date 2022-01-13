-------------------------------------------------------------------------------
-- FILE: init.lua
-- AUTHORS: @Fymyte - https://github.com/Fymyte
-------------------------------------------------------------------------------

--[[ NOTE:

Much of the configuration can be found in either:

./after/plugin/*
  This is where configuration for most plugins is located.
  Configurations are sourced automatically at startup

./plugin/*.lua
  This is where my own config for vim defaults options live.
  - options
  - keymaps

./lua/user/*.lua
  This is where added functionalities are located.
  Utils functions, or plugins extensions are also in this directory

--]]


-- If packer is not installed, install and quit.
if not require 'user.packer_bootstrap'.installed() then
  return
end

vim.g.mapleader = ';'     -- Leader key -> ";"
vim.g.log_level = 'warn'  -- Use this for global debugging

-- Enable plugins
require('plugins')

---------------------------------------------
-- Plugins
---------------------------------------------
-------------------
-- i3 config highlight
-------------------
-- vim.cmd [[
-- aug i3config_ft_detection
--   au!
--   au BufNewFile,BufRead ~/.config/i3/config set filetype=i3
-- aug end
-- ]]

-------------------
-- NvimLSP
-------------------

require('lsp')

--------------------------------------------
-- Curstom commands
--------------------------------------------

-- Quickly open config folder in nerd-tree
vim.cmd( [[command! Config execute 'vs ~/.config/nvim/']] )
-- Easely source config without leaving vim
vim.cmd( [[command! SourceConfig execute 'source ~/.config/nvim/init.lua']] )
-- Easely open Dotfiles directory
vim.cmd( [[command! DotFiles execute 'vs ~/.config']] )
-- Quickly change directory in NERDTree with path completion
vim.cmd( [[command! -nargs=1 -complete=dir NCD NERDTree | cd <args> | NERDTreeCWD]] )

vim.cmd( [[com! SynGroup echo {l,c,n ->
        \   'hi<'    . synIDattr(synID(l, c, 1), n)             . '> '
        \  .'trans<' . synIDattr(synID(l, c, 0), n)             . '> '
        \  .'lo<'    . synIDattr(synIDtrans(synID(l, c, 1)), n) . '> '
        \ }(line("."), col("."), "name")]] )
