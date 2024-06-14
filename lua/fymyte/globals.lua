--- Define helpers functions globally to use anywhere anytime

--# selene: allow(incorrect_standard_library_use)

--- Identity function, used to debug a value.
--- This is usefull to easily print the content of a table
--- @param v any Any variable which can be printed
---@return any v
P = function(v)
  print(vim.inspect(v))
  return v
end

RELOAD = function(name, starts_with_only)
  return require('plenary.reload').reload_module(name, starts_with_only)
end

R = function(name)
  RELOAD(name)
  return require(name)
end
