local ok, notify = pcall(require, 'notify')
if not ok then
  return
end

notify.setup {
  stages = 'fade',
  fps = 60,
  timeout = 3000,
  background_colour = '#303446',
}

local notify_without_offset_encoding_warning = function(msg, ...)
  if msg:match 'warning: multiple different client offset_encodings' then
    return
  end

  notify(msg, ...)
end
-- Replace standard notification with prettyfied ones
vim.notify = notify_without_offset_encoding_warning
