-------------------------------------------------------------------------------
-- File: general.vim
-- Author: Fymyte - @Fymyte
-------------------------------------------------------------------------------
-- Enable plugins
require('plugins')

local opt = vim.opt
local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
---------------------------------------------
--  Global options
---------------------------------------------
-- General
opt.mouse = 'a'           -- Enable mouse usage
opt.autoread = true       -- Auto read when a file is changed from the outside
opt.history = 500         -- Set how many commands to remember
opt.foldcolumn = '1'      -- Set maximun unfolded column to 1
opt.scrolloff = 4         -- Always show 4 lines of the buffer when moving up/down
opt.number = true         -- Show line numbers
opt.cmdheight = 1         -- Set command window height
opt.wildignore = { '*.o', '*~', '*.pyc', '*/.git/*', '*/.hg/*', '*/.svn/*', '*/.DS_Store' }
opt.backspace = { 'eol', 'start', 'indent' } -- Configure backspace so it acts as it should act
opt.lazyredraw = true     -- Don't redraw while executing macros (good performance config)
opt.magic = true          -- Turn magic on for regex
opt.showmatch = true      -- Show matching brackets when text indicator is over them
opt.mat = 2               -- How many tenths of a second to blink when matching brackets
opt.fileformats = { 'unix', 'dos', 'mac' }
opt.timeoutlen = 500      -- Time for a key map to complete
-- show hidden characters
opt.listchars = { tab = '▸ ', trail = '·' }
opt.list = true
-- Errors
opt.errorbells = false
opt.visualbell = false
-- Linebreak
opt.linebreak = true
opt.textwidth = 120
-- Tabs/Spaces
opt.smartcase = true
opt.shiftwidth = 2        -- 1 tab = 2 spaces
opt.tabstop = 2
opt.expandtab = true
-- Search
opt.ignorecase = true     -- Ignore case when searching
opt.smartcase = true
opt.hlsearch = true       -- Highlight search results
opt.incsearch = true      -- Makes search act like in modern browsers
-- Persistent undo file
opt.undodir = fn.getenv('HOME') .. '/.local/share/nvim/undodir' -- when using lua, create a directory `~` in current directory
opt.undofile = true
-- Indentation
opt.autoindent = true
opt.smartindent = true
opt.wrap = true
opt.signcolumn = 'yes'
-- Completion
opt.completeopt = { 'menu', 'menuone', 'preview' }
opt.shortmess:append('c')
-- Status line
opt.laststatus = 2        -- Always show a status line
opt.showmode = false      -- Don't show current mod (already displayed in status line)
-- Copy content of the yanked text in keyboard
cmd( [[autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '' | execute 'OSCYankReg "' | endif]] )
-- Resync file from disk when gaining focus
cmd( [[au FocusGained,BufEnter * checktime]] )
-- Return to last edit position when opening files
cmd( [[au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]] )

-------------------
-- Keymaps
-------------------
local function map(key)
  -- get the extra options
  local opts = { noremap = true, silent = true }
  for i, v in pairs(key) do
    if type(i) == 'string' then opts[i] = v end
  end
  local set_keymap = vim.api.nvim_set_keymap
  set_keymap(key[1], key[2], key[3], opts)
end

g.mapleader = ';'     -- remap leader key to ';'
map( { 'n', '<leader>w', '<cmd>w!<cr>' } ) -- save
-- Move between windows
map( { '', '<C-h>', '<cmd>wincmd h<cr>' } )
map( { '', '<C-j>', '<cmd>wincmd j<cr>' } )
map( { '', '<C-k>', '<cmd>wincmd k<cr>' } )
map( { '', '<C-l>', '<cmd>wincmd l<cr>' } )
-- Move lines
map( { 'n', '<M-j>', [[mz:m+<cr>`z]] } )
map( { 'n', '<M-k>', [[mz:m-2<cr>`z]] } )
map( { 'v', '<M-j>', [[:m'>+<cr>`<my`>mzgv`yo`z]] } )
map( { 'v', '<M-k>', [[:m'<-2<cr>`>my`<mzgv`yo`z]] } )
-- Misc
map( { '', '<leader>l', '<cmd>NERDTreeToggle<cr>' } )
map( { '', '<leader><cr>', '<cmd>noh<cr>' } )

-------------------
-- Colorscheme
-------------------
g.material_terminal_italics = 1
g.material_theme_style = 'darker-community'
opt.termguicolors = true
vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1
cmd( 'colorscheme material' )


---------------------------------------------
-- Plugins
---------------------------------------------
-------------------
-- Statusline
-------------------
local theme = require('lualine.themes.material')
theme.normal.c.bg = '#333333'
require('lualine').setup({
  options = {
    theme = theme,
    section_separators = '',
    component_separators = { left = '∣', right = '∣' },
  },
  sections = {
    lualine_b = {'branch', 'diff',
                  {'diagnostics', sources={'nvim_lsp', 'coc'}}},
  }
})

-------------------
-- NERD (Tree/Commenter)
-------------------
vim.cmd [[
" Ignore object files in NERDTree
let NERDTreeIgnore=['\.o$', '\.epci$', '\.mls$', '\.d$']
" Create default mappings
let g:NERDCreateDefaultMappings = 1
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 0
"" Align line-wise comment delimiters flush left instead of following code indentation
"let g:NERDDefaultAlign = 'left'
"" Set a language to use its alternate delimiters by default
"let g:NERDAltDelims_java = 1
"" Add your own custom formats or override the defaults
"let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1
]]

-------------------
-- i3 config highlight
-------------------
vim.cmd [[
aug i3config_ft_detection
  au!
  au BufNewFile,BufRead ~/.config/i3/config set filetype=i3
aug end

aug md_ft_detection
  au!
  au BufNewFile,BufRead Scratch set filetype=markdown
aug end
]]

-------------------
-- Treesitter
-------------------
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "rust", "python", "c", "cpp", "bash", "cuda", "cmake", "vim", "lua" },
  highlight = {
    enable = true,
    custom_captures = {
      ["variable"] = "Identifier",
      ["variable.parameter"] = "Identifier"
    },
    additional_vim_regex_highlighting = true,
      disable = { "fsharp" },
  },

}


-------------------
-- NvimLSP
-------------------
local lsp_installer = require("nvim-lsp-installer")
-- Provide settings first!
lsp_installer.settings {
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
}
lsp_installer.on_server_ready(function(server)
    local opts = {}
    server:setup(opts)
    vim.cmd [[ do User LspAttachBuffers ]]
end)

local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap = true, silent = true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Setup nvim-cmp.
local cmp = require'cmp'

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
    end,
  },
  mapping = {
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'rust_analyzer', 'clangd', 'pylsp' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    },
    capabilities = capabilities
  }
end
-- Fix colors for lsp errors and warnings
vim.cmd [[
highlight LspDiagnosticsDefaultError guifg=#e41b56
highlight LspDiagnosticsDefaultWarning guifg=#e3641c
]]
-- setup rust-tools
require('rust-tools').setup({})



--map('n', 'gd', )nmap gd :lua vim.lsp.buf.definition()<CR>
--nmap K :lua vim.lsp.buf.hover()<CR>
--nmap gr :lua vim.lsp.buf.references()<CR>
--nmap <leader>rn :lua vim.lsp.buf.rename()<CR>


--------------------------------------------
-- Curstom commands
--------------------------------------------
-- Quickly open config folder in nerd-tree
vim.cmd( [[command! Config execute 'vs ~/.config/nvim/']] )
-- Easely source config without leaving vim
vim.cmd( [[command! SourceConfig execute 'source ~/.config/nvim/init.vim']] )
-- Easely open Dotfiles directory
vim.cmd( [[command! DotFiles execute 'vs ~/.config']] )
-- Quickly change directory in NERDTree with path completion
vim.cmd( [[command! -nargs=1 -complete=dir NCD NERDTree | cd <args> | NERDTreeCWD]] )
