---@type LazyPluginSpec
return {
  'stevearc/oil.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons', 'benomahony/oil-git.nvim' },
  opts = {
    columns = {
      'size',
      'icon',
    },
    lsp_file_methods = {
      autosave_changes = true,
    },
    experimental_watch_for_changes = true,
  },
  config = function(_, opts)
    require('oil').setup(opts)
    vim.keymap.set('n', '<leader>o', require('oil').open, {
      silent = true,
      desc = "[O]il open current file's directory",
    })
  end,
}
