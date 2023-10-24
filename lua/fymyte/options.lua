local opt = vim.opt

opt.mouse = 'nv' -- Enable mouse in normal and visual mode only
opt.autoread = true -- Auto read when a file is changed from the outside
opt.history = 500 -- Set how many commands to remember
opt.foldcolumn = '1' -- Set maximun unfolded column to 1
opt.scrolloff = 4 -- Always show 4 lines of the buffer when moving up/down
opt.number = true -- Show line numbers
opt.relativenumber = true -- Enalble relative numbers
opt.cmdheight = 1 -- Set command window height
opt.wildignore = { '*.o', '*~', '*.pyc', '*/.git/*', '*/.hg/*', '*/.svn/*', '*/.DS_Store' }
opt.backspace = { 'eol', 'start', 'indent' } -- Configure backspace so it acts as it should act
--opt.lazyredraw = true -- Don't redraw while executing macros (good performance config)
opt.swapfile = false -- Do not use swapfiles
opt.magic = true -- Turn magic on for regex
opt.showmatch = true -- Show matching brackets when text indicator is over them
opt.mat = 2 -- How many tenths of a second to blink when matching brackets
opt.fileformats = { 'unix', 'dos', 'mac' }
opt.timeoutlen = 500 -- Time for a key map to complete
opt.updatetime = 500 -- Time for `CursorHold` event to trigger (ms)
opt.hidden = true -- Do not unload backgroup buffers

-- Splits
opt.splitright = true -- vsplit open new window on the right

-- show hidden characters where we might not want them
opt.listchars = { tab = '▸ ', trail = '·' }
opt.list = true

-- Turn bells off
opt.errorbells = false
opt.visualbell = false
vim.cmd [[set t_vb=]] -- Remove terminal blinking
opt.belloff = 'all'
opt.termguicolors = true

-- Linebreak
opt.linebreak = true
opt.textwidth = 120

-- Tabs/Spaces
opt.shiftwidth = 2 -- 1 tab = 2 spaces
opt.tabstop = 2
opt.softtabstop = 2
opt.expandtab = true

-- Indentation
opt.autoindent = true
opt.smartindent = true
opt.wrap = true
opt.signcolumn = 'yes'

-- Search
opt.ignorecase = true -- Ignore case when searching
opt.smartcase = true -- Take case into account only if uppercase is searched
opt.hlsearch = true -- Highlight previous search results
opt.incsearch = true -- Highlight search restults incrementaly

-- Persistent undo file
opt.undodir = vim.fn.stdpath 'data' .. '/undodir' --[[@as vim.opt.undodir]]
opt.undofile = true
-- Spell checking
opt.spell = false -- Spell checking is not set by default (define per ft using ftplugin)
opt.spelllang = { 'en_us' }
-- Completion
opt.completeopt = { 'menu', 'menuone', 'preview' }
opt.shortmess:append 'c'

-- Status line
opt.laststatus = 3 -- Always show a status line
opt.showmode = false -- Don't show current mod (already displayed in status line)

-- Folds
opt.foldlevelstart = 99
opt.foldcolumn = '0'

opt.conceallevel = 2

-- Vertical diffs
opt.diffopt:append 'vertical'

-- Auto formating options (:h fo-table)
opt.formatoptions = opt.formatoptions
  - 'a' -- Auto formatting is BAD.
  - 't' -- Don't auto format my code. I got linters for that.
  + 'c' -- In general, I like it when comments respect textwidth
  + 'q' -- Allow formatting comments w/ gq
  - 'o' -- O and o, don't continue comments
  + 'r' -- But do continue when pressing enter.
  + 'n' -- Indent past the formatlistpat, not underneath it.
  + 'j' -- Auto-remove comments if possible.
  + '1'

vim.g.python3_host_prog = 'python3'
vim.g.loaded_python_provider = 0

vim.filetype.add {
  extension = {
    qml = 'qmljs',
    scm = 'query',
    kdl = 'kdl',
  },
  filename = {
    Scratch = 'markdown',
  },
}

local autocmd = require('fymyte.utils').autocmd
local augroup = require('fymyte.utils').augroup

autocmd('BufReadPost', {
  group = augroup 'AutoReturnToLastPos',
  desc = 'return to last edition position when open a file',
  pattern = '*',
  callback = function()
    if vim.fn.line '\'"' > 1 and vim.fn.line '\'"' <= vim.fn.line '$' then
      vim.cmd [[normal! g'"]]
    end
  end,
})

autocmd('TermOpen', {
  group = augroup 'AutoTermInsertMode',
  desc = 'enter insert mode when opening a terminal',
  pattern = '*',
  command = 'startinsert',
})

autocmd('TextYankPost', {
  group = augroup 'Highlight_Yank',
  desc = 'highlight selection on yank',
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { higroup = 'IncSearch', timeout = 500 }
  end,
})

-- TODO: re-enable when more confortable with vim
-- Disable entering in Ex mode
vim.keymap.set('n', 'Q', '', { noremap = true })
