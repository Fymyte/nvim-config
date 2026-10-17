local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

vim.pack.add {
  Utils.gh 'tpope/vim-surround',
  -- Allow repetition using `.`
  Utils.gh 'tpope/vim-repeat',
  -- Operations on words
  Utils.gh 'tpope/vim-abolish',
  -- ][ danse
  Utils.gh 'tpope/vim-unimpaired',
  -- Builtin basic shell commands
  Utils.gh 'tpope/vim-eunuch',
  Utils.gh 'tpope/vim-fugitive',
}

vim.keymap.set('n', '[q', '<cmd>try | cprev | catch | clast | endtry<cr>', { noremap = true })
vim.keymap.set('n', ']q', '<cmd>try | cnext | catch | cfirst| endtry<cr>', { noremap = true })
vim.keymap.set('n', '[l', '<cmd>try | lprev | catch | llast | endtry<cr>', { noremap = true })
vim.keymap.set('n', ']l', '<cmd>try | lnext | catch | lfirst| endtry<cr>', { noremap = true })

local fugitive = require 'fymyte.fugitive'

local fugitive_grp = augroup('fugitive_autocmd', { clear = true })
autocmd('BufReadPost', {
  group = fugitive_grp,
  desc = 'mark fugitive buffers as delete on quit',
  pattern = 'fugitive://*',
  callback = function()
    vim.bo.bufhidden = 'delete'
  end,
})

autocmd('DirChanged', {
  group = fugitive_grp,
  desc = 'Update fugitive status when changing cwd',
  -- :Git must fire fugitive's BufReadCmd, or the status buffer stays empty
  nested = true,
  callback = function()
    if fugitive.is_status_open() then
      fugitive.close_status()
      local win = vim.api.nvim_get_current_win()
      fugitive.open_status()
      vim.api.nvim_set_current_win(win)
    end
  end,
})

autocmd('User', {
  group = fugitive_grp,
  desc = 'open commit message in vsplit on the far left',
  pattern = 'FugitiveEditor',
  callback = function()
    vim.cmd.wincmd 'H'
    vim.cmd.resize { 86, mods = { vertical = true } }
    vim.opt_local.winfixwidth = true
    vim.opt_local.textwidth = 80
  end,
})

autocmd('User', {
  group = fugitive_grp,
  pattern = 'FugitiveIndex',
  desc = 'Resize fugigive index window',
  callback = function()
    vim.cmd.resize(10)
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.winfixheight = true
  end,
})

vim.keymap.set('n', '<leader>tg', fugitive.toggle_status, { desc = '[T]oggle [G]it status' })
vim.keymap.set('n', '<M-g>', fugitive.toggle_status, { desc = '[T]oggle [G]it status' })
