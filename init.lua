-------------------------------------------------------------------------------
-- File: general.vim
-- Author: Fymyte - @Fymyte
-------------------------------------------------------------------------------
local opt = vim.opt
local cmd = vim.cmd
local api = vim.api
local lsp = vim.lsp
local fn = vim.fn
local g = vim.g

-- Enable plugins
require('plugins')
require('notify').setup({ stages = 'slide', timeout = 3000 })
vim.notify = require('notify')
local utils = require('utils')

---------------------------------------------
--  Global options
---------------------------------------------

g.log_level = 'warn'
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
opt.updatetime = 1000     -- Time for `CursorHold` event to trigger (ms)
-- show hidden characters
opt.listchars = { tab = '▸ ', trail = '·' }
opt.list = true
-- Errors
opt.errorbells = false
opt.visualbell = false
cmd([[set t_vb=]])        -- Remove terminal blinking
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

local orig_nvim_open_win = api.nvim_open_win
function api.nvim_open_win(buffer, enter, config)
  config = config or {}
  config.border = config.border or 'rounded'
  return orig_nvim_open_win(buffer, enter, config)
end

-------------------
-- Keymaps
-------------------

local function generic_map(key, map_fun)
   -- get the extra options
  local opts = { noremap = true, silent = true }
  for i, v in pairs(key) do
    if type(i) == 'string' then opts[i] = v end
  end
  map_fun(key[1], key[2], key[3], opts)
  utils.log('trace',
    string.format('add new keymap: { mode = %q, keys: %q, cmd: %q }', key[1], key[2], key[3]))
end
local function map(key)
  generic_map(key, api.nvim_set_keymap)
end
local function buf_map(bufnr, key)
  generic_map(key, function(m, k, c, o) api.nvim_buf_set_keymap(bufnr, m, k, c, o) end)
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
-- Ignore object files in NERDTree
NERDTreeIgnore = { [[\.o$]], [[\.epci$]], [[\.mls$]], [[\.d$]] }
vim.cmd [[
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
    disable = {},
  },

}


-------------------
-- NvimLSP
-------------------

--- require `nvim-lsp-installer`
local lsp_installer = require('nvim-lsp-installer')

-- Use rounded windows everywhere
local border = 'rounded'--{ '╭', '─', '╮', '│', '╯','─', '╰', '│' }
local orig_util_open_floating_preview = lsp.util.open_floating_preview
function lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end
--- Configure diagnostics displayed info
vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = true,
  severity_sort = false,
})
-- Change diagnostic symbols in the sign column
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
lsp.set_log_level(g.log_level)

--- Show source in diagnostics
--vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
--  virtual_text = {
--    --prefix = '●',
----- @version 0.6+
--    source = "always",  -- Or "if_many"
--  }
--})

--- Provide additional key mappings when a lsp server is attached
local function custom_attach(client, bufnr)
  -- Mappings.
  buf_map(bufnr, { 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>' } )
  buf_map(bufnr, { 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>' } )
  buf_map(bufnr, { 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>' } )
  buf_map(bufnr, { 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>' } )
  buf_map(bufnr, { 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>' } )
  buf_map(bufnr, { 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>' } )
  buf_map(bufnr, { 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>' } )
  buf_map(bufnr, { 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>' } )
  buf_map(bufnr, { 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>' } )
  buf_map(bufnr, { 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>' } )
  buf_map(bufnr, { 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>' } )
  buf_map(bufnr, { 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>' } )
  buf_map(bufnr, { 'n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>' } )
  buf_map(bufnr, { 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>' } )
  buf_map(bufnr, { 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>' } )
  buf_map(bufnr, { 'n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>' } )
  buf_map(bufnr, { 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>' } )

  -- Show line diagnostic on cursor hold
  cmd([[autocmd CursorHold <buffer> lua vim.lsp.diagnostic.show_line_diagnostics()]])

  utils.log('debug', string.format("Language server %s attached", client.name))
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
    ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
    ['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
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
    { name = 'nvim_lua' }
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
    { name = 'path' },
    { name = 'nvim_lsp' }
  }, {
    { name = 'cmdline' }
  })
})

-- Setup lspconfig.
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
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
--local servers = { 'rust_analyzer', 'clangd', 'pylsp' }
local default_opts = {
  on_attach = custom_attach,
  flags = {
    debounce_text_changes = 150,
  },
  capabilities = capabilities,
  log_level = g.log_level,
}
lsp_installer.on_server_ready(function(server)
  local runtime_path = vim.split(package.path, ";")
  table.insert(runtime_path, "lua/?.lua")
  table.insert(runtime_path, "lua/?/init.lua")
  local server_opts = {
    ['sumneko_lua'] = function ()
      default_opts.settings = {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            version = "LuaJIT",
            -- Setup your lua path
            path = runtime_path,
          },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = { "vim" },
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = api.nvim_get_runtime_file("", true),
          },
          -- Do not send telemetry data containing a randomized but unique identifier
          telemetry = {
            enable = false,
          },
        }
      }
      return default_opts
    end
  }

  server:setup(server_opts[server.name] and server_opts[server.name]() or default_opts)
  vim.cmd([[do User LspAttachBuffers]])
  utils.log('debug', string.format('Language server %q is ready', server.name))
end)


--for _, server in ipairs(servers) do
--  lsp[server].setup(default_opts)
--end

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
vim.cmd( [[command! SourceConfig execute 'source ~/.config/nvim/init.lua']] )
-- Easely open Dotfiles directory
vim.cmd( [[command! DotFiles execute 'vs ~/.config']] )
-- Quickly change directory in NERDTree with path completion
vim.cmd( [[command! -nargs=1 -complete=dir NCD NERDTree | cd <args> | NERDTreeCWD]] )
