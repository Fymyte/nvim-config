--- Define helpers functions globally to use anywhere anytime

--# selene: allow(incorrect_standard_library_use)

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
