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
---@param deps SystemDep
---@param name string
local function check_system_deps(deps, name)
  for _, dep in pairs(deps) do
    if vim.fn.executable(dep) ~= 1 then
      local msg = ('%q is not installed'):format(dep)
      vim.notify(msg, 'warn', { title = name })
    end
  end
end

local log_levels = { ['TRACE'] = 0, ['DEBUG'] = 1, ['INFO'] = 2, ['WARN'] = 3, ['ERROR'] = 4 }
vim.tbl_add_reverse_lookup(log_levels)

--- Log as a notification only when `vim.g.log_level`
--- is greater than `min_lvl`
--- @param min_lvl number | string
--- @param msg string
function M.log(min_lvl, msg)
  local log_level = g.log_level
  if type(min_lvl) == 'string' then
    min_lvl = assert(log_levels[min_lvl:upper()], string.format('bad log level: %q', min_lvl))
  end
  if type(log_level) == 'string' then
    log_level = assert(log_levels[log_level:upper()], string.format('bad main log level: %q', log_level))
  end
  assert(type(min_lvl) == 'number' and type(log_level) == 'number', 'log levels are either string or number')
  if log_level <= min_lvl then
    log_level = string.lower(log_levels[min_lvl])
    vim.notify(msg, log_level, { title = log_level })
  end
end

-- local function generic_map(key, map_fun)
--   -- get the extra options
--   local opts = { noremap = true, silent = true }
--   for i, v in pairs(key) do
--     if type(i) == 'string' then
--       opts[i] = v
--     end
--   end
--   map_fun(key[1], key[2], key[3], opts)
--   M.log('trace', string.format('add new keymap: { mode = %q, keys: %q, cmd: %q }', key[1], key[2], key[3]))
-- end

M.check_system_deps = check_system_deps
M.system_deps = system_deps

return M
