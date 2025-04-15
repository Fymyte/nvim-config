---@type LazyPluginSpec
return {
  'stevearc/conform.nvim',
  opts = {
    formatters_by_ft = {
      lua = { 'stylua' },
      c = { 'clang-format' },
      nix = { 'alejandra' },
      python = { 'pyproject-fmt' },
    },

    default_format_opts = {
      lsp_format = 'fallback',
    },
  },
  config = function(_, opts)
    require('conform').setup(opts)

    vim.keymap.set({ 'n', 'v' }, '<leader>f', require('conform').format, { desc = '[F]ormat' })
  end,
}
