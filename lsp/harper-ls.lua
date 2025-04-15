---@type vim.lsp.Config
return {
  cmd = { 'harper-ls', '--stdio' },

  filetypes = {
    'c',
    'cpp',
    'cs',
    'gitcommit',
    'go',
    'html',
    'java',
    'javascript',
    'lua',
    'markdown',
    'nix',
    'python',
    'ruby',
    'rust',
    'swift',
    'toml',
    'typescript',
    'typescriptreact',
    'haskell',
    'cmake',
    'typst',
    'php',
    'dart',
  },

  root_markers = { '.git' },

  settings = {
    ['harper-ls'] = {
      userDictPath = vim.fn.stdpath 'config' .. '/spell/dictionaries/user.dict',
      fileDictPath = vim.fn.stdpath 'config' .. '/spell/dictionaries/per-file',
      linters = {
        SentenceCapitalization = false,
      },
    },
  },
}
