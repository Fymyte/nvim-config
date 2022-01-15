local opt = vim.opt
local cmd = vim.cmd

opt.mouse = 'nv'          -- Enable mouse in normal and visual mode only
opt.autoread = true       -- Auto read when a file is changed from the outside
opt.history = 500         -- Set how many commands to remember
opt.foldcolumn = '1'      -- Set maximun unfolded column to 1
opt.scrolloff = 4         -- Always show 4 lines of the buffer when moving up/down
opt.number = true         -- Show line numbers
opt.relativenumber = true -- Enalble relative numbers
opt.cmdheight = 1         -- Set command window height
opt.wildignore = { '*.o', '*~', '*.pyc', '*/.git/*', '*/.hg/*', '*/.svn/*', '*/.DS_Store' }
opt.backspace = { 'eol', 'start', 'indent' } -- Configure backspace so it acts as it should act
opt.lazyredraw = true     -- Don't redraw while executing macros (good performance config)
opt.swapfile = false      -- Do not use swapfiles
opt.magic = true          -- Turn magic on for regex
opt.showmatch = true      -- Show matching brackets when text indicator is over them
opt.mat = 2               -- How many tenths of a second to blink when matching brackets
opt.fileformats = { 'unix', 'dos', 'mac' }
opt.timeoutlen = 500      -- Time for a key map to complete
opt.updatetime = 1000     -- Time for `CursorHold` event to trigger (ms)

-- show hidden characters where we might not want them
opt.listchars = { tab = '▸ ', trail = '·' }
opt.list = true

-- Turn bells off
opt.errorbells = false
opt.visualbell = false
cmd([[set t_vb=]])        -- Remove terminal blinking
opt.belloff = 'all'

-- Linebreak
opt.linebreak = true
opt.textwidth = 120

-- Tabs/Spaces
opt.smartcase = true
opt.shiftwidth = 2        -- 1 tab = 2 spaces
opt.tabstop = 2
opt.softtabstop = 2
opt.expandtab = true

-- Indentation
opt.autoindent = true
opt.smartindent = true
opt.wrap = true
opt.signcolumn = 'yes'

-- Search
opt.ignorecase = true     -- Ignore case when searching
opt.smartcase = true
opt.hlsearch = false      -- Do not highlight previous search results
opt.incsearch = true      -- Highlight search restults incrementaly

-- Persistent undo file
opt.undodir = vim.fn.getenv('HOME') .. '/.local/share/nvim/undodir'
opt.undofile = true
-- Spell checking
opt.spell = false         -- Spell checking is not set by default (define per ft using ftplugin)
opt.spelllang = { 'en_us' }
-- Completion
opt.completeopt = { 'menu', 'menuone', 'preview' }
opt.shortmess:append('c')

-- Status line
opt.laststatus = 2        -- Always show a status line
opt.showmode = false      -- Don't show current mod (already displayed in status line)

-- Auto formating options
opt.formatoptions = opt.formatoptions
  - "a" -- Auto formatting is BAD.
  - "t" -- Don't auto format my code. I got linters for that.
  + "c" -- In general, I like it when comments respect textwidth
  + "q" -- Allow formatting comments w/ gq
  - "o" -- O and o, don't continue comments
  + "r" -- But do continue when pressing enter.
  + "n" -- Indent past the formatlistpat, not underneath it.
  + "j" -- Auto-remove comments if possible.
  - "2" -- I'm not in gradeschool anymore

cmd( [[
augroup defaultFileType
  autocmd!
  autocmd BufNewFile,BufRead Scratch set filetype=markdown
augroup end

augroup enableFileTypeSpelling
  autocmd!
  " Enable spell checking in all buffers of the following filetypes.
  autocmd FileType gitcommit,markdown,mkd,rst,text,yaml
    \ setlocal spell
  autocmd Filetype help setlocal nospell
augroup END

augroup OSCYankReg
  autocmd!
  " Copy content of the yanked text in keyboard
  autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '' | execute 'OSCYankReg "' | endif
augroup end

augroup LastPos
  autocmd!
  " Resync file from disk when gaining focus
  au FocusGained,BufEnter * checktime
  " Return to last edit position when opening files
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup end
]] )

-- TODO: re-enable when more confortable with vim
-- Disable entering in Ex mode
cmd( [[nnoremap Q <Nop>]] )
