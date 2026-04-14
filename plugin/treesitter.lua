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

local function try_install_parser(lang)
  local nvimts = require 'nvim-treesitter'
  local languages = nvimts.get_available()
  for _, v in pairs(languages) do
    if v == lang then
      nvimts.install(lang):wait(5000)
      return true
    end
  end

  return false
end

-- Automatically enable treesitter highlighting when opening a file
autocmd('FileType', {
  group = augroup('tree-sitter-highlight', { clear = true }),
  callback = function(args)
    local lang = vim.treesitter.language.get_lang(args.match)
    -- If available in nvim-treesitter, install the parser
    try_install_parser(lang)

    -- Make sure that if it fails to activate tree-sitter highlighting, at
    -- least there is old school regex syntax enabled
    local ok = pcall(vim.treesitter.start, args.buf, lang)
    if not ok then
      vim.bo[args.buf].syntax = 'on'
    end
  end,
})
