---@type LazyPluginSpec
return {
  'stevearc/oil.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons', 'benomahony/oil-git.nvim' },
  ---@module "oil"
  ---@type oil.Config
  opts = {
    columns = {
      'size',
      'icon',
    },
    constrain_cursor = "name",
    watch_for_changes = true,
    lsp_file_methods = {
      enabled = true,
      autosave_changes = true,
    },
    experimental_watch_for_changes = true,
    keymaps = {
      ['<leader>yf'] = { 'actions.copy_to_system_clipboard', mode = 'n' },
      ['<leader>yp'] = { 'actions.copy_to_system_clipboard', mode = 'n' },
      ['<leader>p'] = { 'actions.paste_from_system_clipboard', mode = 'n' },
    },
  },
  lazy = false,
  config = function(_, opts)
    require('oil').setup(opts)
    vim.keymap.set('n', '<leader>o', '<cmd>Oil<cr>', {
      silent = true,
      desc = "[O]il open parent directory",
    })
  end,
}
