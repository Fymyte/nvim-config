local api = vim.api
local g = vim.g

local M = {}

---@type SystemDep string|string[]

---Check for system dependencies
---If argument is an array, this is a `one of` type of match
---@param ... SystemDep[]
---@return missing dependencies
local system_deps = function(...)
  function table.pack(...) return { n = select("#", ...), ... } end
  local args = table.pack(...)
  local missing = {}
  for i=1,args.n do
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
      error('dependency is either a string or array of string')
    end
  end
  return missing
end

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

local function generic_map(key, map_fun)
  -- get the extra options
  local opts = { noremap = true, silent = true }
  for i, v in pairs(key) do
    if type(i) == 'string' then
      opts[i] = v
    end
  end
  map_fun(key[1], key[2], key[3], opts)
  M.log('trace', string.format('add new keymap: { mode = %q, keys: %q, cmd: %q }', key[1], key[2], key[3]))
end

function M.map(key)
  generic_map(key, api.nvim_set_keymap)
end
function M.buf_map(bufnr, key)
  generic_map(key, function(m, k, c, o)
    api.nvim_buf_set_keymap(bufnr, m, k, c, o)
  end)
end

M.check_system_deps = check_system_deps
M.system_deps = system_deps

return M
