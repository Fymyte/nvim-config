local augroup = require('fymyte.utils').augroup
local autocmd = vim.api.nvim_create_autocmd

local function try_install_parser(lang)
  local ok, nvimts = pcall(require, 'nvim-treesitter')
  if not ok then
    return false
  end

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
  group = augroup 'tree-sitter-highlight',
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
