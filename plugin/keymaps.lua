local map = function(mode, lhs, rhs, opts)
  opts = opts or { noremap = true, silent = true }
  vim.keymap.set(mode, lhs, rhs, opts)
end

-------------------
-- Keymaps
-------------------

-- Quick save
map('n', '<leader>w', '<cmd>write!<cr>')
-- Undo breakpoints
map('i', ',', ',<C-g>u')
map('i', '.', '.<C-g>u')
map('i', '!', '!<C-g>u')
map('i', '?', '?<C-g>u')
map('i', ':', ':<C-g>u')
-- Cycle throught buffers
map('', '<C-b>p', '<cmd>bprev<cr>')
map('', '<C-b><C-p>', '<cmd>bprev<cr>')
map('', '<C-b>n', '<cmd>bnext<cr>')
map('', '<C-b><C-n>', '<cmd>bnext<cr>')
-- Move lines
map('n', '<M-j>', [[<cmd>m.+1<cr>==]])
map('n', '<M-k>', [[<cmd>m.-2<cr>==]])
map('i', '<M-j>', [[<esc><cmd>m.+1<cr>==]])
map('i', '<M-k>', [[<esc><cmd>m.-2<cr>==]])
-- Those two needs to use `:` instead of `<cmd>` because otherwise
-- range is not inserted before the command
map('v', '<M-j>', [[:m '>+1<cr>gv=gv]])
map('v', '<M-k>', [[:m '<-2<cr>gv=gv]])
map('v', '<', '<gv')
map('v', '>', '>gv')
-- Join line above at the end of the current line
map('n', '<leader>j', [[<cmd>m-2|j<cr>]])
-- Motions
map('n', '0', '^') -- use 0 to go to first char of line
-- map('n', '=', '+')
-- Term
map('t', '<Esc>', '<C-\\><C-n>')
-- Misc
map('', '<leader><Space>', '<cmd>noh<cr>')

local function showFugitiveGit()
  if vim.fn.FugitiveHead() ~= '' then
    vim.cmd [[
    Git
    wincmd H
    vertical resize 31
    setlocal nonumber
    setlocal norelativenumber
    setlocal winfixwidth
    ]]
  end
end
map('n', '<leader>gs', showFugitiveGit)

local function executor()
  if vim.bo.filetype == 'lua' then
    loadstring(vim.api.nvim_get_current_line())()
  end
end
vim.keymap.set('n', '<leader>x', executor, { noremap=true, silent=true })

local function save_and_execute()
  if vim.bo.filetype == 'lua' then
    vim.cmd [[
    :silent! write
    :luafile %
    ]]
  end
end
vim.keymap.set('n', '<leader><leader>x', save_and_execute, { noremap=true, silent=true })
