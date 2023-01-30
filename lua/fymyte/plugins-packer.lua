local function check_system_deps(deps, name)
  for _, dep in pairs(deps) do
    if vim.fn.executable(dep) ~= 1 then
      local msg = ('%q is not installed. (optionnal deps for %s)'):format(dep, name)
      vim.notify(msg, 'warn', { title = 'Packer' })
    end
  end
end

packer.reset()
packer.startup {
  function(use)
    -- Neorg (Note taking)
    use {
      'nvim-neorg/neorg',
      run = ':Neorg sync-parsers',
      requires = {
        'nvim-lua/plenary.nvim',
        'nvim-neorg/neorg-telescope',
      },
    }

    -- Utils
    use 'wellle/targets.vim' -- Add a tone of textobjects
    use 'windwp/nvim-autopairs' -- Auto close match pairs
    use 'tommcdo/vim-exchange' -- Exchange two elements
    use 'milisims/nvim-luaref'
    use 'folke/todo-comments.nvim' -- TODOS class highlights
    use 'klen/nvim-config-local' -- Securly source local nvim config
    use 'gpanders/editorconfig.nvim' -- Load editorconfig
    use 'danymat/neogen' -- Doc auto generation
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

    -- Telescope (Fuzzy finder)
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use 'nvim-telescope/telescope-file-browser.nvim'
    use 'nvim-telescope/telescope-project.nvim'
    use 'nvim-telescope/telescope-ui-select.nvim'
    use 'nvim-telescope/telescope-packer.nvim'
    use 'nvim-telescope/telescope-live-grep-args.nvim'
    use {
      'rudism/telescope-dict.nvim',
      run = function()
        check_system_deps({ 'dictd' }, 'telescope-dict')
      end,
    }
    use 'kyazdani42/nvim-web-devicons'
    use {
      'nvim-telescope/telescope.nvim',
      requires = 'nvim-lua/plenary.nvim',
      run = function()
        check_system_deps({ 'fd', 'rg' }, 'telescope')
      end,
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
        'rcarriga/cmp-dap',
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

    -- use {
    --   'nvim-treesitter/nvim-treesitter-textobjects',
    --   after = 'nvim-treesitter'
    -- }
    -- UI
    use {
      'onsails/lspkind-nvim',
      requires = { 'neovim/nvim-lspconfig' },
    }
    -- use { 'mhinz/vim-startify' }
  end,
  config = {
    display = {
      open_fn = function()
        return require('packer.util').float { border = 'rounded' }
      end,
    },
  },
}
