local g = vim.g

local M = {}

---@alias SystemDependency string
---@alias EitherSystemDep SystemDependency[] at least one of the SystemDependency is available
---@alias SystemDep SystemDependency[]
---@alias SystemDeps (SystemDependency|EitherSystemDep)[]

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

---@alias augroup integer

---Create a new autocmd group
---@param name string
---@return augroup
M.augroup = function(name)
  return vim.api.nvim_create_augroup(name, { clear = true })
end

---@alias AuCmdCallback string|function

---@class AuCmdSpec
---@field [1] string: 1 desc
---@field [2] augroup
---@field [3] AuCmdCallback
---@field [4] integer|nil
---@field once boolean whether the autocmd should be run only once
---@field desc string autocmd description

---Creates a new auto command
---
---```lua
--- autocmd('BufEnter', augroup('MyAugroup'), function() print('Buffer entered')end, 0, {
---     desc = 'My cool autocmd',
---   })
---```
---@param args AuCmdSpec
M.autocmd_s = function(args)
  local event = args[1]
  local group = args[2]
  local callback = args[3]

  vim.api.nvim_create_autocmd(event, {
    group = group,
    buffer = args[4],
    callback = function()
      callback()
    end,
    once = args.once,
    desc = args.desc,
  })
end

M.autocmd = vim.api.nvim_create_autocmd

---Check if dependencies are installed and executable on the system
---@param deps SystemDeps[]
---@param name string
local function check_system_deps(deps, name)
  local missing = system_deps(deps)
  if #missing == 0 then return end

  local msg
  if #missing > 1 then msg = 'are' else msg = 'is' end

  msg = ('%q %s not installed'):format(missing, msg)
  vim.notify(msg, vim.log.levels.WARN, { title = name })
end

M.check_system_deps = check_system_deps
M.system_deps = system_deps

return M
