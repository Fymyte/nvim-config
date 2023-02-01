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
    -- Utils
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

    -- LSP
    use 'neovim/nvim-lspconfig'
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
  end,
  config = {
    display = {
      open_fn = function()
        return require('packer.util').float { border = 'rounded' }
      end,
    },
  },
}
