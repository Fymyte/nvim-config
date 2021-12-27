-- spellchecker: disable

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
      '~/.config/nvim/my_pluggins/vim-kitty',
      ft = { 'kitty', 'kitty-session' },
    }
    use {
      'Fymyte/mesonic',
      as = 'vim-messon',
    }
    use { 'Fymyte/vim-css-color' }
    use {
      'Fymyte/vim-rasi',
      ft = { 'rasi' }
    }
    use {
      'amadeus/vim-css',
      ft = { 'css' },
    }

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
    -- use { 'kaicataldo/material.vim' }
    use {
      'rebelot/kanagawa.nvim',
      as = 'kanagawa',
    }
    use {
      'nvim-lualine/lualine.nvim',
      -- after = 'material.vim',
      after = 'kanagawa',
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

