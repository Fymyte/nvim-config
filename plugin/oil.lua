vim.pack.add {
  Utils.gh 'stevearc/oil.nvim',
  Utils.gh 'nvim-tree/nvim-web-devicons',
  Utils.gh 'benomahony/oil-git.nvim',
}

require('oil').setup {
  columns = {
    'size',
    'icon',
  },
  constrain_cursor = 'name',
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
}

vim.keymap.set('n', '<leader>o', '<cmd>Oil<cr>', {
  silent = true,
  desc = '[O]il open parent directory',
})
