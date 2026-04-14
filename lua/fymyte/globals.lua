--- Define helpers functions globally to use anywhere anytime

Utils = require'fymyte.utils'

--- Identity function, used to debug a value.
--- This is useful to easily print the content of a table
---@param v any Any variable which can be printed
---@return any v
P = function(v)
  print(vim.inspect(v))
  return v
end
