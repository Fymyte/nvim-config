vim.pack.add { Utils.gh '3rd/image.nvim' }

require('image').setup {
  integrations = {
    markdown = { enabled = true },
    rst = { enabled = true },
    html = { enabled = true },
    css = { enabled = true },
  },
}
