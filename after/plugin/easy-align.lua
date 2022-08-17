local opts = { silent = true, noremap = true }

vim.keymap.set({ 'n', 'v' }, 'ga', '<Plug>(EasyAlign)', opts)
