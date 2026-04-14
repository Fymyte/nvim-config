vim.pack.add { Utils.gh 'j-hui/fidget.nvim' }

require('fidget').setup {
  progress = { display = { render_limit = 2, done_ttl = 1 } },
  notification = { window = { max_width = 80 } },
}
vim.notify = require('fidget').notify
vim.notify_once = require('fidget').notify
