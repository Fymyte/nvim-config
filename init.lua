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

-------------------
-- NvimLSP
-------------------

require('lsp')
