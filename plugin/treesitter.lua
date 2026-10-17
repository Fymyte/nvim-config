local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

vim.pack.add {
  Utils.gh 'nvim-treesitter/nvim-treesitter',
  Utils.gh 'nvim-treesitter/nvim-treesitter-context',
}

autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'nvim-treesitter' and (kind == 'update' or kind == 'install') then
      if not ev.data.active then
        vim.cmd.packadd 'nvim-treesitter'
      end
      local builtin_parsers = {
        'c',
        'lua',
        'vim',
        'vimdoc',
        'markdown',
        'query',
      }
      require('nvim-treesitter').install(builtin_parsers)
      require('nvim-treesitter').update()
    end
  end,
})

local function start_ts_highlight(buf, lang)
  if not pcall(vim.treesitter.start, buf, lang) then
    vim.bo[buf].syntax = 'ON'
    return false
  end
  return true
end

-- Automatically enable treesitter highlighting when opening a file
autocmd('FileType', {
  group = augroup('tree-sitter-highlight', { clear = true }),
  callback = function(args)
    local ts = require 'nvim-treesitter'
    local lang = vim.treesitter.language.get_lang(args.match)

    if
      start_ts_highlight(args.buf, lang) -- ts highlighting started
      or not vim.list_contains(ts.get_available(), lang) -- no parser available
      or vim.list_contains(ts.get_installed 'parsers', lang) -- parser installed but failed
    then
      return
    end

    -- NOTE: do not wait for the install. vim.wait runs pending callbacks inside this
    -- autocmd, where autocmds do not nest, so a scheduled :edit skips BufReadCmd
    ts.install(lang):await(function()
      vim.schedule(function()
        if vim.api.nvim_buf_is_valid(args.buf) then
          start_ts_highlight(args.buf, lang)
        end
      end)
    end)
  end,
})
