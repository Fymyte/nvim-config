local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
  -- Bring packer plugin into scope
  vim.cmd [[packadd packer.nvim]]
end

local M = {}

-- Whethere packer has just been installed
M.bootstraped = is_bootstrap

return M
