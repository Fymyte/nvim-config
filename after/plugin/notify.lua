-- Replace standard notification with prettyfied ones
local ok, notify = pcall(require, 'notify')
if ok then
  notify.setup {
    stages = 'slide',
    timeout = 3000,
  }
  vim.notify = notify
end

