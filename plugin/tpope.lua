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

local function open_fugitive_buf()
  local ok, head = pcall(vim.fn.FugitiveHead)
  if ok and head ~= '' then
    vim.cmd.Git()
  end
end

local function get_fugitive_buf()
  return vim.fn.bufnr 'fugitive:///*/.git/{worktrees/*}\\\\\\{0,1\\}/$'
end

local function close_fugitive_buf()
  local fugitive_buf = get_fugitive_buf()
  if fugitive_buf ~= -1 then
    vim.api.nvim_buf_delete(fugitive_buf, {})
  end
end

function ToggleFugitiveGit()
  local fugitive_buf = get_fugitive_buf()
  if fugitive_buf ~= -1 then
    close_fugitive_buf()
  else
    open_fugitive_buf()
  end
end

local fugitive_grp = augroup('fugitive_autocmd', { clear = true })
autocmd('BufReadPost', {
  group = fugitive_grp,
  desc = 'mark fugitive buffers as delete on quit',
  pattern = 'fugitive://*',
  callback = function()
    vim.b.bufhidden = 'delete'
  end,
})

autocmd('DirChanged', {
  group = fugitive_grp,
  desc = 'Update fugitive status when changing cwd',
  callback = function()
    close_fugitive_buf()

    -- TODO: currently, opening fugitive buf right here actually make the closing of the previous buffer fail.
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

vim.keymap.set('n', '<leader>tg', ToggleFugitiveGit, { desc = '[T]oggle [G]it status' })
