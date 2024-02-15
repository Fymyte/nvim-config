--- This file defines keymaps not handled by any plugins.
--- Keymaps associated with plugins should be located with the plugins
--- declaration itself in `lua/fymyte/plugins/<file>`

local opts = { noremap = true, silent = true }

local keymap = function(mode, lhs, rhs, desc)
  local local_opts = vim.tbl_extend('keep', opts, { desc = desc })
  vim.keymap.set(mode, lhs, rhs, local_opts)
end

-- Quick save
keymap('n', '<leader>w', '<cmd>write!<cr>', '[W]rite buffer')
-- Overload open
keymap('n', 'gx', ':!open <c-r><c-a><cr>', 'Open content under cursor')
-- Do not add breakpoints when typing punctuation
keymap('i', ',', ',<C-g>u')
keymap('i', '.', '.<C-g>u')
keymap('i', '!', '!<C-g>u')
keymap('i', '?', '?<C-g>u')
keymap('i', ':', ':<C-g>u')
-- Cycle throught buffers
keymap('', '<leader>bp', '<cmd>bprev<cr>', '[B]uffer [P]rev')
keymap('', '<leader>bn', '<cmd>bnext<cr>', '[B]uffer [N]ext')
-- Cycle throught tabs
keymap('n', '<leader>tn', '<cmd>tabnext<cr>', '[T]ab [N]ext')
keymap('n', '<leader>tp', '<cmd>tabprev<cr>', '[T]ab [P]rev')
keymap('n', '<leader>te', '<cmd>tabedit<cr>', '[T]ab [E]dit')
keymap('n', '<leader>ts', '<cmd>tab split<cr>', '[T]ab [S]plit')
-- Dont move cursor when joining lines
keymap('n', 'J', 'mzJ`z')
-- Join line above at the end of the current line
keymap('n', '<leader>j', [[<cmd>m-2|j<cr>]], '[J]oin line above after this line')
-- Motions
keymap('n', '0', '^') -- use 0 to go to first char of line
-- Formatting
keymap('n', '<leader>f', function() vim.lsp.buf.format { async = true } end)
-- Misc
keymap('n', '<leader><leader>', '<cmd>noh<cr>', 'Clear search highlighting')
-- Paste without losing clipboard content
keymap('x', '<leader>p', '"_dP', '[P]aste without loosing clipboard content')
-- Linewise text object
keymap('x', 'il', 'g_o^')
keymap('o', 'il', '<cmd>normal vil<cr>')
keymap('x', 'al', '$o^')
keymap('o', 'al', '<cmd>normal val<cr>')
-- Buffer text object
keymap('x', 'i%', 'GoggV')
keymap('o', 'i%', '<cmd>normal vi%<cr>')

keymap('n', '<leader>do', vim.diagnostic.open_float, '[D]iagnostic [O]pen')
keymap('n', '[d', vim.diagnostic.goto_prev, 'Prev [D]iagnostic')
keymap('n', ']d', vim.diagnostic.goto_next, 'Next [D]iagnostic')
keymap('n', '<leader>dq', vim.diagnostic.setloclist, '[D]iagnostic [Q]uick fix')

keymap('t', '<S-esc>', '<C-\\><C-n>', 'Terminal normal mode')

local function executor()
  if vim.bo.filetype == 'lua' then
    loadstring(vim.api.nvim_get_current_line())()
  end
end
keymap('n', '<leader>x', executor, 'E[x]ecute current line in luafile')

local function save_and_execute()
  if vim.bo.filetype == 'lua' then
    vim.cmd [[silent! write]]
    vim.cmd.luafile(vim.fn.expand '%')
  end
end
keymap('n', '<leader><leader>x', save_and_execute, 'E[x]ecute the current lua file')
