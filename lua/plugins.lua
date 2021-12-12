-- spellchecker: disable
--local Plug = vim.fn['plug#']
--vim.call('plug#begin', '~/.config/nvim/autoload/plugged')
-- """"""""""""""""""""""""
-- " Utils
-- """"""""""""""""""""""""
-- add icons before files and folders
--  Plug 'ryanoasis/vim-devicons'
-- file explorer
--  Plug 'scrooloose/nerdtree'
-- edit same text in multiple files (also subfolders)
  --Plug 'dyng/ctrlsf.vim'
-- git commands inside vim
--  Plug 'tpope/vim-fugitive'
-- Format c/cpp using clang format
-- "  Plug 'rhysd/vim-clang-format'
-- Easier commenting using keybindings
--  Plug 'preservim/nerdcommenter'
-- Snippets support

--  " Fuzzy search
--  " Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
--  Plug 'junegunn/fzf'
--  Plug 'junegunn/fzf.vim'
-- copy/paste everywhere
--  Plug 'ojroques/vim-oscyank'
--  Plug 'rcarriga/nvim-notify'

--  Plug 'vimwiki/vimwiki'

--""""""""""""""""""""""""
--" Highlighting and LSP
--""""""""""""""""""""""""
--  " Highlighting with treesitter
--  Plug('nvim-treesitter/nvim-treesitter', { ['do'] = 'TSUpdate' })
-- Neovin integrated lsp client
--  Plug 'neovim/nvim-lspconfig'
--  " Install lsp sever for many language
--  Plug 'williamboman/nvim-lsp-installer'
-- LSP based Autocompletion with more sources
--  Plug 'hrsh7th/cmp-nvim-lsp'
--  Plug 'hrsh7th/cmp-buffer'
--  Plug 'hrsh7th/cmp-path'
--  Plug 'hrsh7th/cmp-cmdline'
--  Plug 'hrsh7th/cmp-nvim-lua'
--  Plug 'hrsh7th/nvim-cmp'
--  Plug 'f3fora/cmp-spell' -- spellchecking
-- additional hint for rust
--  Plug 'simrat39/rust-tools.nvim'

--""""""""""""""""""""""""
--" Language supports
--""""""""""""""""""""""""
--  " Auto pairs for '(' '[' '{'
--  Plug 'jiangmiao/auto-pairs'
-- " heptagon
-- "  Plug 'Fymyte/hept.vim'
-- GNU AS
--"  Plug 'shirk/vim-gas'
--  Plug 'igankevich/mesonic'
--  Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
--  "Plug 'thindil/Ada-Bundle's
-- i3 config
--  Plug 'moon-musick/vim-i3-config-syntax'
-- rofi config
-- Plug 'cantoromc/vim-rasi'
-- kitty config
--  Plug 'fladson/vim-kitty'

--""""""""""""""""""""""""
--" Visual
--""""""""""""""""""""""""
-- color background for rbg, hex and anssi colors
--  Plug 'ap/vim-css-color'
-- more icons for lsp doc
--  Plug 'onsails/lspkind-nvim'
-- Material colorscheme for vim
--  Plug ('kaicataldo/material.vim', { branch = 'main' })
-- better status line
--  Plug 'nvim-lualine/lualine.nvim'
--  Plug 'itchyny/lightline.vim'
-- better vim startup screen
--  Plug 'mhinz/vim-startify'
--  Plug 'dstein64/vim-startuptime'

--vim.call('plug#end')


--local function bootstrap_packer()
--  local fn = vim.fn
--  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
--  if fn.empty(fn.glob(install_path)) > 0 then
--    if fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path}) then
--      require('packer').sync()
--    end
--  end
--end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

local function check_system_deps(deps)
  for _, dep in pairs(deps) do
    if vim.fn.executable(dep) ~= 1 then
      local msg = ('%q is not installed. (optionnal deps for telescope)'):format(dep)
      vim.notify(msg, 'warn', { title = 'Packer' })
    end
  end
end


return require('packer').startup({
  function(use)
    use { 'wbthomason/packer.nvim' }
    -- More syntax
    use {
      'moon-musick/vim-i3-config-syntax',
      as = 'vim-i3',
      ft = { 'i3' },
    }
    use {
      'fladson/vim-kitty',
      ft = { 'kitty', 'kitty-session' },
    }
    use {
      'igankevich/mesonic',
      as = 'vim-messon',
      ft = { 'meson', 'mesonopt' },
    }
    use { 'ap/vim-css-color' }

    -- Utils
    use {
      'kyazdani42/nvim-tree.lua',
      requires = {
        'kyazdani42/nvim-web-devicons', -- optional, for file icon
      },
      config = function() require('treeviewer') end,
    }
    use { 'preservim/nerdcommenter' }
    use { 'ojroques/vim-oscyank' }
    use { 'rcarriga/nvim-notify' }
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use {
      'nvim-telescope/telescope.nvim',
      requires = {
        { 'nvim-lua/plenary.nvim' },
      },
      run = check_system_deps({ 'fd', 'rg' }),
    }
    use { 'windwp/nvim-autopairs' }
    --use {
    --  'chipsenkbeil/distant.nvim',
    --  config = function()
    --    require('distant').setup {
    --      -- Applies Chip's personal settings to every machine you connect to
    --      --
    --      -- 1. Ensures that distant servers terminate with no connections
    --      -- 2. Provides navigation bindings for remote directories
    --      -- 3. Provides keybinding to jump into a remote file's parent directory
    --      ['*'] = require('distant.settings').chip_default()
    --    }
    --  end
    --}

    -- Autocompletion
    use {
      'hrsh7th/nvim-cmp',
      requires = {
        'hrsh7th/vim-vsnip',
        'hrsh7th/cmp-vsnip',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-nvim-lua',
        'f3fora/cmp-spell',
      },
    }

    -- LSP
    use {
      'williamboman/nvim-lsp-installer',
      requires = { 'neovim/nvim-lspconfig' },
    }
    use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      requires = { 'nvim-treesitter/nvim-treesitter-textobjects' }
    }
    use {
      'nvim-treesitter/playground',
      run = ':TSInstall query',
      after = 'nvim-treesitter',
    }
    use {
      'simrat39/rust-tools.nvim',
      requires = { 'neovim/nvim-lspconfig' },
    }

    -- UI
    use {
      'onsails/lspkind-nvim',
      requires = { 'neovim/nvim-lspconfig' }
    }
    use { 'kaicataldo/material.vim' }
    use {
      'nvim-lualine/lualine.nvim',
      after = 'material.vim',
      config = function () require('statusline') end
    }
    use { 'mhinz/vim-startify' }
    use { 'dstein64/vim-startuptime' }

    --bootstrap_packer()
  end,
  config = {
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'rounded' })
      end,
    },
    log = { level = vim.g.log_level },
  },
})

-- TODO: check distant and vimwiki extentions
