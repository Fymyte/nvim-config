vim.pack.add { { src = Utils.gh 'stevearc/conform.nvim' } }

require('conform').setup {
  formatters_by_ft = {
    lua = { 'stylua' },
    c = { 'clang-format' },
    nix = { 'alejandra' },
    python = { 'pyproject-fmt' },
  },

  default_format_opts = {
    lsp_format = 'fallback',
  },
}

-- Override formatexpr 
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
