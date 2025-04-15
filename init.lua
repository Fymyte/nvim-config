-------------------------------------------------------------------------------
-- FILE: init.lua
-- AUTHORS: @Fymyte - https://github.com/Fymyte
-------------------------------------------------------------------------------

--[[ NOTE:

Much of the configuration can be found in either:

./lua/fymyte/globals.lua
  Globally available functions/variables across my config files

./lua/fymyte/options.lua
  Preference for vim builtin options
./lua/fymyte/keymaps.lua
  My custom keymaps

./lua/fymyte/diagnostics.lua
  Neovim builtin diagnostics configuration

./snippets/*
  My own snippets
--]]

-- remove navigation using space
vim.keymap.set('', '<space>', '', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.log_level = vim.log.levels.WARN -- Use this for global debugging

-- Load helper functions first to have them available for after
require 'fymyte.globals'

-- Custom vim.opt configuration
require 'fymyte.options'
-- Additional keymaps
require 'fymyte.keymaps'
-- Builtin diagnostics configuration
require 'fymyte.diagnostics'

-- Builtin lsp configuration
require 'fymyte.lsp'
-- Builtin treesitter configuration
require 'fymyte.treesitter'

-- Bootstrap Neovim package manager
local lazy_opts = require 'fymyte.lazy-bootstrap'
require('lazy').setup('fymyte.plugins', lazy_opts)
