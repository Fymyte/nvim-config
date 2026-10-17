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

return M
