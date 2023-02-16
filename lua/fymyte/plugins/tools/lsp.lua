return {
  -- Sane lsp default config
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      -- Lsp interaction between mason and lspconfig
      'williamboman/mason-lspconfig.nvim',
      'mfussenegger/nvim-dap',
      -- 'rcarriga/nvim-dap-ui',
      'p00f/clangd_extensions.nvim',
      'barreiroleo/ltex_extra.nvim',
      { 'simrat39/rust-tools.nvim', dependencies = 'nvim-lua/plenary.nvim' },
      { 'folke/neodev.nvim', config = true },
      'hrsh7th/cmp-nvim-lsp',
    },
    opts = {},
    config = function(_, opts)
      local lsp = require 'fymyte.tools.lsp'
      lsp.override_open_floating_preview { border = 'rounded' }
      lsp.setup_servers(lsp.servers)
    end,
  },
}
