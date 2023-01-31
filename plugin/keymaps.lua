local opts = { noremap = true, silent = true }

local keymap = function(mode, lhs, rhs, desc)
  local local_opts = vim.tbl_extend("keep", opts, { desc = desc })
  vim.keymap.set(mode, lhs, rhs, local_opts)
end

-------------------
-- Keymaps
-------------------

-- Quick save
keymap('n', '<leader>w', '<cmd>write!<cr>', "write buffer")
-- Do not add breakpoints when typing punctuation
keymap('i', ',', ',<C-g>u')
keymap('i', '.', '.<C-g>u')
keymap('i', '!', '!<C-g>u')
keymap('i', '?', '?<C-g>u')
keymap('i', ':', ':<C-g>u')
-- Cycle throught buffers
keymap('', '<C-b>p', '<cmd>bprev<cr>', "Next buffer")
keymap('', '<C-b><C-p>', '<cmd>bprev<cr>')
keymap('', '<C-b>n', '<cmd>bnext<cr>')
keymap('', '<C-b><C-n>', '<cmd>bnext<cr>')
-- Cycle throught tabs
keymap('n', '<leader>tn', '<cmd>tabnext<cr>')
keymap('n', '<leader>tp', '<cmd>tabprev<cr>')
keymap('n', '<leader>te', '<cmd>tabedit<cr>')
-- Move lines (handandled by mini.move)
-- keymap('n', '<M-j>', [[<cmd>m.+1<cr>==]])
-- keymap('n', '<M-k>', [[<cmd>m.-2<cr>==]])
-- keymap('i', '<M-k>', [[<esc><cmd>m.-2<cr>==]])
-- keymap('i', '<M-j>', [[<esc><cmd>m.+1<cr>==]])
-- Those two needs to use `:` instead of `<cmd>` because otherwise
-- range is not inserted before the command
keymap('v', '<M-j>', [[:m '>+1<cr>gv=gv]])
keymap('v', '<M-k>', [[:m '<-2<cr>gv=gv]])
keymap('v', '<', '<gv')
keymap('v', '>', '>gv')
-- Dont move cursor when joining lines
keymap('n', 'J', 'mzJ`z')
-- Join line above at the end of the current line
keymap('n', '<leader>j', [[<cmd>m-2|j<cr>]])
-- Motions
keymap('n', '0', '^') -- use 0 to go to first char of line
-- map('n', '=', '+')
-- Term
keymap('t', '<Esc>', '<C-\\><C-n>')
-- Misc
keymap('n', '<leader><leader>', '<cmd>noh<cr>')
-- Paste without losing clipboard content
keymap('x', '<leader>p', '"_dP')

local function showFugitiveGit()
  if vim.fn.FugitiveHead() ~= '' then
    vim.cmd [[
    Git
    wincmd H
    vertical resize 31
    " resize 12
    setlocal nonumber
    setlocal norelativenumber
    setlocal winfixwidth
    ]]
  end
end
function ToggleFugitiveGit()
  if vim.fn.buflisted(vim.fn.bufname 'fugitive:///*/.git//$') ~= 0 then
    vim.cmd [[ execute ":bdelete" bufname('fugitive:///*/.git//$') ]]
  else
    showFugitiveGit()
  end
end

local function executor()
  if vim.bo.filetype == 'lua' then
    loadstring(vim.api.nvim_get_current_line())()
  end
end
vim.keymap.set('n', '<leader>x', executor, opts)

local function save_and_execute()
  if vim.bo.filetype == 'lua' then
    vim.cmd [[
    :silent! write
    :luafile %
    ]]
  end
end
vim.keymap.set('n', '<leader><leader>x', save_and_execute, opts)

-- vim.keymap.set('n', '<F5>', '<cmd>UndotreeToggle<CR>', opts)
vim.keymap.set('n', '<F6>', ToggleFugitiveGit, opts)
