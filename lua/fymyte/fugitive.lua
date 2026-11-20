local M = {}

function M.status_bufs()
  return vim.tbl_filter(function(buf)
    return vim.b[buf].fugitive_type == 'index' and vim.fn.bufwinid(buf) ~= -1
  end, vim.api.nvim_list_bufs())
end

function M.is_status_open()
  return #M.status_bufs() > 0
end

function M.close_status()
  for _, buf in ipairs(M.status_bufs()) do
    vim.api.nvim_buf_delete(buf, { force = true })
  end
end

function M.open_status()
  if vim.fn.FugitiveGitDir() == '' then
    return vim.notify('fugitive: no git dir for current buffer/cwd', vim.log.levels.WARN)
  end
  vim.cmd.Git()
end

function M.toggle_status()
  if M.is_status_open() then
    M.close_status()
  else
    M.open_status()
  end
end

local mr_ns = vim.api.nvim_create_namespace 'fymyte_fugitive_mr'
-- Fugitive reloads the status on every stage or focus, so we do not call the CLI each time
local MR_TTL_MS = 30 * 1000
local mr_cache = {}

local function mr_draw(buf)
  vim.api.nvim_buf_clear_namespace(buf, mr_ns, 0, -1)
  local entry = mr_cache[vim.b[buf].fymyte_mr_key]
  if not entry or not entry.mr then
    return
  end
  for i, line in ipairs(vim.api.nvim_buf_get_lines(buf, 0, -1, false)) do
    if line == '' then
      return
    end
    if line:match '^Merge: ' or line:match '^Rebase: ' or line:match '^Pull: ' then
      vim.api.nvim_buf_set_extmark(buf, mr_ns, i - 1, 0, { virt_text = { { '!' .. entry.mr.id, 'Special' } } })
      return
    end
  end
end

local function mr_fetch(key, url, branch, cwd)
  local cmd
  if url:find('github.com', 1, true) then
    cmd = { 'gh', 'pr', 'list', '--head', branch, '--json', 'number,url' }
  else
    cmd = { 'glab', 'mr', 'list', '--source-branch', branch, '-F', 'json' }
  end

  local function done(mr)
    mr_cache[key] = { mr = mr, time = vim.uv.now() }
    for _, buf in ipairs(M.status_bufs()) do
      if vim.b[buf].fymyte_mr_key == key then
        mr_draw(buf)
      end
    end
    vim.api.nvim_exec_autocmds('User', { pattern = 'FymyteMrChanged' })
  end

  -- vim.system() throws when the CLI is not installed
  local ok = pcall(vim.system, cmd, { cwd = cwd, text = true }, function(res)
    local mr
    if res.code == 0 then
      local decoded, list = pcall(vim.json.decode, res.stdout)
      local first = decoded and type(list) == 'table' and list[1]
      mr = first and { id = first.number or first.iid, url = first.url or first.web_url }
    end
    vim.schedule(function()
      done(mr)
    end)
  end)
  if not ok then
    done(nil)
  end
end

-- Same rule as the Push: line of fugitive's status, without a git process
local function push_target(buf)
  local branch = vim.fn.FugitiveHead(0, buf)
  if branch == '' then
    return
  end
  local function get(name, default)
    return vim.fn.FugitiveConfigGet(name, buf, default)
  end
  local remote = get('branch.' .. branch .. '.pushRemote', get('remote.pushDefault', get('branch.' .. branch .. '.remote', 'origin')))
  if get('push.default', 'simple') == 'upstream' then
    branch = get('branch.' .. branch .. '.merge', ''):match '^refs/heads/(.+)$'
  end
  local url = remote ~= '.' and vim.fn.FugitiveRemoteUrl(remote, buf) or ''
  if branch and url ~= '' then
    return url, branch
  end
end

--- Look up the open MR/PR of the buffer's push branch, at most once per MR_TTL_MS
function M.refresh_mr(buf)
  buf = (buf == nil or buf == 0) and vim.api.nvim_get_current_buf() or buf
  local url, branch = push_target(buf)
  local key = url and url .. ' ' .. branch
  vim.b[buf].fymyte_mr_key = key
  if vim.b[buf].fugitive_type == 'index' then
    mr_draw(buf)
  end
  if not key then
    return
  end

  local entry = mr_cache[key]
  if entry and (entry.pending or vim.uv.now() - entry.time < MR_TTL_MS) then
    return
  end
  -- Keep the old id on screen while the new one is fetched
  mr_cache[key] = { mr = entry and entry.mr, time = entry and entry.time or 0, pending = true }
  mr_fetch(key, url, branch, vim.fn.FugitiveWorkTree(buf))
end

--- Cached MR/PR of the buffer's push branch, as { id, url }, or nil
function M.mr(buf)
  local entry = mr_cache[vim.b[buf or 0].fymyte_mr_key]
  return entry and entry.mr
end

--- Open the cached MR/PR of the current buffer in the browser
function M.open_mr()
  local mr = M.mr()
  if not mr then
    return
  end
  local _, err = vim.ui.open(mr.url)
  if err then
    vim.notify(err, vim.log.levels.ERROR)
  end
end

local REF_HEADERS = { Head = true, Merge = true, Rebase = true, Pull = true, Push = true }

--- :GBrowse the branch, file or commit under the cursor in the status buffer
function M.browse()
  local line = vim.api.nvim_get_current_line()
  local header, ref = line:match '^(%a+): (.+)$'
  local arg
  if REF_HEADERS[header] then
    -- fugitive#PorcelainCfile() resolves a ref to its commit, which loses the branch
    arg = vim.fn.fnameescape(ref)
  elseif line:match '^%u%l+.* %(%d+%)$' then
    -- Section titles have no object, open the repository instead
    arg = ''
  else
    arg = vim.fn['fugitive#PorcelainCfile']()
  end
  local ok, err = pcall(vim.cmd, 'GBrowse ' .. arg)
  if not ok then
    vim.notify(err, vim.log.levels.ERROR)
  end
end

--- Open the MR/PR when the cursor line shows its id, else :GBrowse the object under the cursor
function M.browse_mr()
  local row = vim.api.nvim_win_get_cursor(0)[1] - 1
  if not M.mr() or #vim.api.nvim_buf_get_extmarks(0, mr_ns, { row, 0 }, { row, -1 }, {}) == 0 then
    return M.browse()
  end
  M.open_mr()
end

return M
