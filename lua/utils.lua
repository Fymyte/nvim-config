local g = vim.g

local M = {}

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

return M
