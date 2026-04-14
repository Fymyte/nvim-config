vim.pack.add { Utils.gh 'folke/todo-comments.nvim' }

require('todo-comments').setup {
  highlight = { pattern = [[.*<(KEYWORDS)\s*(\([^)]+\))?:]] },
  search = { pattern = [[\b(KEYWORDS)(\([^)]*\))?:]] },
}
