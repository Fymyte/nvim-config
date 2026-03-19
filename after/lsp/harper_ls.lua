---@type vim.lsp.Config
return {
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
