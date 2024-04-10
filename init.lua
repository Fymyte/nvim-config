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
  This is where config for vim default options live.
  - keymaps
  - diagnostics

./lua/fymyte/*.lua
  This is where added functionalities are located.
  Utils functions, or plugins extensions are also in this directory

--]]

-- Remove navigation using space
vim.keymap.set('', '<space>', '', { noremap = true, silent = true })
vim.g.mapleader = ' '
---@type integer
vim.g.log_level = vim.log.levels.WARN -- Use this for global debugging

-- Load helper functions first to have them available for after
require 'fymyte.globals'
require 'fymyte.options'
require 'fymyte.keymaps'
require 'fymyte.diagnostics'

-- Load rocks package manager
require 'fymyte.rocks'

-- Eearly setup for colorscheme
require 'rocks'.packadd 'catppuccin'
vim.cmd.colorscheme 'catppuccin'


-- Bootstrap nvim package manager
-- local lazy_opts = require 'fymyte.lazy-bootstrap'
-- require('lazy').setup('fymyte.plugins', lazy_opts)
