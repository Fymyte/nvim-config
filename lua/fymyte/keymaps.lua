--- This file defines keymaps not handled by any plugins.
--- Keymaps associated with plugins should be located with the plugins
--- declaration itself in `lua/fymyte/plugins/<file>`

--- Shortcut for vim.keymap.set, but always set noremap and silent to true
--- @param mode string|string[]
--- @param lhs string
--- @param rhs string|function
--- @param desc string?
local keymap = function(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
end

-- Quick save
keymap('n', '<leader>w', '<cmd>write!<cr>', '[W]rite buffer')

-- Do not add breakpoints when typing punctuation. This allows to under writing a lua statement in a single press of `u`
-- instead of one for every field
keymap('i', ',', ',<C-g>u')
keymap('i', '.', '.<C-g>u')
keymap('i', '!', '!<C-g>u')
keymap('i', '?', '?<C-g>u')
keymap('i', ':', ':<C-g>u')

-- Override default <C-m> behavior to act as o in insert mode instead of CR
keymap('i', '<C-m>', '<cmd>normal o<cr>')

-- Cycle through tabs (I don't use tags, so use ][t for tabs instead)
keymap('n', ']t', '<cmd>tabnext<cr>', '[T]ab [N]ext')
keymap('n', '[t', '<cmd>tabprev<cr>', '[T]ab [P]rev')
keymap('n', '<leader>te', '<cmd>tabedit<cr>', '[T]ab [E]dit')
keymap('n', '<leader>ts', '<cmd>tab split<cr>', '[T]ab [S]plit')
-- Don't move cursor when joining lines
keymap('n', 'J', 'mzJ`z')
-- Join line above at the end of the current line
keymap('n', '<leader>j', [[<cmd>m-2|j<cr>]], '[J]oin line above after this line')
-- Misc
keymap('n', '<leader><leader>', '<cmd>noh<cr>', 'Clear search highlighting')
-- Paste without losing clipboard content
keymap('x', '<leader>p', '"_dP', '[P]aste without loosing clipboard content')
-- Linewise text object
keymap('x', 'il', 'g_o^')
keymap('o', 'il', '<cmd>normal vil<cr>')
keymap('x', 'al', '$o0')
keymap('o', 'al', '<cmd>normal val<cr>')
-- Buffer text object
keymap('x', 'i%', 'GoggV')
keymap('o', 'i%', '<cmd>normal vi%<cr>')

keymap('n', '<leader>do', vim.diagnostic.open_float, '[D]iagnostic [O]pen')
keymap('n', '<leader>dr', vim.diagnostic.reset, '[D]iagnostic [R]eset')
keymap('n', '[d', function()
  vim.diagnostic.jump { count = -1, float = true }
end, 'Prev [D]iagnostic')
keymap('n', ']d', function()
  vim.diagnostic.jump { count = 1, float = true }
end, 'Next [D]iagnostic')
keymap('n', '<leader>dq', vim.diagnostic.setloclist, '[D]iagnostic [Q]uick fix')

keymap('n', '<leader>o', function()
  vim.cmd.edit(vim.fn.expand '%:p:h')
end, "[O]pen file's directory")
keymap('n', '<leader>f', 'gq%', '[F]ormat')

-- Common yanking ops
keymap('n', '<leader>yf', function()
  vim.fn.setreg('@', vim.fn.expand '%:t')
  vim.fn.setreg('+', vim.fn.expand '%:t')
end, '[Y]ank [F]ilename of current file')
keymap('n', '<leader>yp', function()
  vim.fn.setreg('@', vim.fn.expand '%:p')
  vim.fn.setreg('+', vim.fn.expand '%:t')
end, '[Y]ank [P]ath to current file')

keymap('t', '<S-esc>', '<C-\\><C-n>', 'Terminal normal mode')
keymap('t', '<C-;><C-;>', '<C-\\><C-n>', 'Terminal normal mode')
keymap('t', '<C-w>', '<C-\\><C-n><C-w>')

---@param mode 'n'|'v'
local function executor(mode)
  if vim.bo.filetype ~= 'lua' then
    return
  end
  if mode == 'n' then
    assert(loadstring(vim.api.nvim_get_current_line()))()
  else
    local region = vim.fn.getregion(vim.fn.getpos '.', vim.fn.getpos 'v', { type = vim.fn.mode() })
    local exe = table.concat(region, '\n')
    loadstring(exe)()
  end
end
keymap('n', '<leader>x', function()
  executor 'n'
end, 'E[x]ecute current line in luafile')
keymap('v', '<leader>x', function()
  executor 'v'
end, 'E[x]ecute current selection in luafile')

local function save_and_exec_file()
  if vim.bo.filetype ~= 'lua' then
    return
  end
  vim.cmd [[silent! write]]
  vim.cmd.luafile(vim.fn.expand '%')
end
keymap('n', '<leader><leader>x', save_and_exec_file, 'E[x]ecute the current lua file')
