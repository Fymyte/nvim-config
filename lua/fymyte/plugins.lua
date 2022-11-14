local has_packer, packer = pcall(require, 'packer')
if not has_packer then
  return
end

vim.api.nvim_create_autocmd("BufWritePost", {
  group = vim.api.nvim_create_augroup("packer_user_config", {}),
  pattern = "plugins.lua",
  command = "source <afile> | PackerCompile | PackerSync"
})

local function check_system_deps(deps, name)
  for _, dep in pairs(deps) do
    if vim.fn.executable(dep) ~= 1 then
      local msg = ('%q is not installed. (optionnal deps for %s)'):format(dep, name)
      vim.notify(msg, 'warn', { title = 'Packer' })
    end
  end
end


packer.reset()
packer.startup{
  function(use)
    -- Actual package manager
    use 'wbthomason/packer.nvim'

    -- More syntax
    use 'mboughaba/i3config.vim'
    use 'fladson/vim-kitty'
    use 'ap/vim-css-color'
    use 'Fymyte/mbsync.vim'
    use 'amadeus/vim-css'
    use 'Fymyte/rasi.vim'
    use 'max397574/colortils.nvim'
    use 'NvChad/nvim-colorizer.lua'

    -- Neorg (Note taking)
    -- use {
    --   'nvim-neorg/neorg',
    --   requires = {
    --     'nvim-lua/plenary.nvim',
    --     'nvim-neorg/neorg-telescope',
    --   },
    -- }

    -- Utils
    use 'numToStr/Comment.nvim'  -- Smart comments
    use 'numToStr/FTerm.nvim'    -- Floating terminal
    use 'ojroques/vim-oscyank'   -- Yank also to keyboard
    use 'wellle/targets.vim'     -- Add a tone of textobjects
    use 'tpope/vim-surround'     -- Surround textobjects with pairs
    use 'tpope/vim-repeat'       -- Allow repetition using `.`
    use 'tpope/vim-abolish'      -- Operations on words
    use 'tpope/vim-unimpaired'   -- ][ danse
    use 'windwp/nvim-autopairs'  -- Auto close match pairs
    use 'tommcdo/vim-exchange'   -- Exchange two elements
    use 'rcarriga/nvim-notify'   -- Beautify vim.notify
    use 'stevearc/dressing.nvim' -- Beautify vim.ui.input
    use 'junegunn/vim-easy-align'
    use 'folke/persistence.nvim' -- Easy session management
    use 'mbbill/undotree'
    use 'milisims/nvim-luaref'
    use 'folke/todo-comments.nvim' -- TODOS class highlights
    -- use 'ellisonleao/glow.nvim'
    -- use {
    --   'sidebar-nvim/sidebar.nvim',
    --   branch = 'dev',
    -- }
    -- Mailbox
    -- use {
    --   'soywod/himalaya',
    --   rtp = 'vim',
    --   run = check_system_deps({ 'himalaya' }, 'himalaya')
    -- }

    -- Git
    use 'tpope/vim-fugitive'
    use 'tpope/vim-rhubarb'
    use { 'lewis6991/gitsigns.nvim', require = 'nvim-lua/plenary.nvim' }

    -- Telescope (Fuzzy finder)
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use 'nvim-telescope/telescope-file-browser.nvim'
    use 'nvim-telescope/telescope-project.nvim'
    use 'nvim-telescope/telescope-ui-select.nvim'
    use 'nvim-telescope/telescope-packer.nvim'
    use {
      'rudism/telescope-dict.nvim',
      run = function() check_system_deps({ 'dictd' }, 'telescope-dict') end,
    }
    use 'kyazdani42/nvim-web-devicons'
    use {
      'nvim-telescope/telescope.nvim',
      requires = 'nvim-lua/plenary.nvim',
      run = function() check_system_deps({ 'fd', 'rg' }, 'telescope') end,
      -- branch = '0.1.x',
    }

    -- Autocompletion
    use {
      'hrsh7th/nvim-cmp',
      requires = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lsp-signature-help',
        'hrsh7th/cmp-nvim-lsp-document-symbol',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-nvim-lua',
        'f3fora/cmp-spell',
        'saadparwaiz1/cmp_luasnip',
        'L3MON4D3/LuaSnip',
        { 'petertriho/cmp-git', requires = 'nvim-lua/plenary.nvim' },
        'rcarriga/cmp-dap'
      },
    }

    -- LSP
    use 'neovim/nvim-lspconfig'
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
    use 'jose-elias-alvarez/null-ls.nvim'
    use 'mfussenegger/nvim-dap'
    use 'rcarriga/nvim-dap-ui'
    use 'p00f/clangd_extensions.nvim'
    use 'barreiroleo/ltex_extra.nvim'
    use {
      'simrat39/rust-tools.nvim',
      requires = {
        'nvim-lua/plenary.nvim',
      },
    }
    use 'folke/neodev.nvim'
    -- use 'glepnir/lspsaga.nvim'
    -- use 'j-hui/fidget.nvim'
    use 'vigoux/notifier.nvim'

    -- Treesitter
    use {
      'nvim-treesitter/nvim-treesitter',
      run = function() require('nvim-treesitter.install').update({ with_sync = true }) end
    }
    -- use {
    --   'nvim-treesitter/nvim-treesitter-textobjects',
    --   after = 'nvim-treesitter'
    -- }
    use {
      'nvim-treesitter/playground',
      run = ':TSInstall query',
      after = 'nvim-treesitter',
    }

    -- UI
    use {
      'onsails/lspkind-nvim',
      requires = { 'neovim/nvim-lspconfig' }
    }
    use {
      'rebelot/kanagawa.nvim',
      as = 'kanagawa',
    }
    use {
      'catppuccin/nvim',
      as = 'catppuccin',
    }
    use {
      'marko-cerovac/material.nvim',
      as = 'material',
    }
    use {
      'nvim-lualine/lualine.nvim',
      after = 'kanagawa',
    }
    -- use { 'mhinz/vim-startify' }
    -- use { 'dstein64/vim-startuptime' }

  end,
  config = {
    display = {
      open_fn = function()
        return require'packer.util'.float{ border = 'rounded' }
      end,
    },
  }
}

