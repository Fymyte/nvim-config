if not pcall(require, 'todo-comments') then
  return
end

require('todo-comments').setup {
  highlight = { pattern = [[.*<(KEYWORDS)\s*(\([^)]+\))?:]] },
  search = { pattern = [[\b(KEYWORDS)(\([^)]*\))?:]] },
}
