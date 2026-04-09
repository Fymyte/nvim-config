local augroup = require('fymyte.utils').augroup
local autocmd = vim.api.nvim_create_autocmd

vim.lsp.enable {
  'harper_ls',
  'emmylua_ls',
  'taplo',
  'yaml-ls',
  'jsonls',
  'nil_ls',
  'nixd',
  'gopls',
  'clangd',
  'ruff',
  'pylsp',
  'neocmakelsp',
  'bashls',
  'ltex_plus',
  'zls',
  'qmlls',
}

vim.lsp.semantic_tokens.enable(true)
vim.lsp.inlay_hint.enable(true)
autocmd({ 'CursorHold', 'CursorHoldI' }, {
  group = augroup 'document-highlight',
  callback = vim.lsp.buf.document_highlight,
})
autocmd('CursorMoved', {
  group = augroup 'document-highlight',
  callback = vim.lsp.buf.clear_references,
})
