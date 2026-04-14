local g = vim.g

local M = {}

---@alias SystemDependency string
---@alias EitherSystemDep SystemDependency[] at least one of the SystemDependency is available
---@alias SystemDep SystemDependency[]
---@alias SystemDeps (SystemDependency|EitherSystemDep)

---Check for system dependencies
---If argument is an array, this is a `one of` type of match
---@param ... SystemDeps
---@return SystemDep: missing dependencies
local system_deps = function(...)
  local args = { n = select('#', ...), ... }
  local missing = {}
  for i = 1, args.n do
    local dep = args[i]
    if type(dep) == 'table' then
      local found = false
      for _, opt_dep in pairs(dep) do
        if vim.fn.executable(opt_dep) == 1 then
          found = true
          break
        end
      end
      if not found then
        table.insert(missing, dep)
      end
    elseif type(dep) == 'string' then
      if vim.fn.executable(dep) ~= 1 then
        table.insert(missing, dep)
      end
    else
      error 'dependency is either a string or array of string'
    end
  end
  return missing
end

---Check if dependencies are installed and executable on the system
---@param deps SystemDeps[]
---@param name string
local function check_system_deps(deps, name)
  local missing = system_deps(deps)
  if #missing == 0 then
    return
  end

  local msg
  if #missing > 1 then
    msg = 'are'
  else
    msg = 'is'
  end

  msg = ('%q %s not installed'):format(missing, msg)
  vim.notify(msg, vim.log.levels.WARN, { title = name })
end

M.check_system_deps = check_system_deps
M.system_deps = system_deps

M.gh = function(user_repo) return "https://github.com/"..user_repo end 

return M
