---@type LazySpec
return {
  'stevearc/quicker.nvim',
  ft = 'qf',
  ---@module "quicker"
  ---@type quicker.SetupOptions
  opts = {},
  config = function(_, opts)
    require('quicker').setup(opts)
    vim.keymap.set('n', '<leader>q', require('quicker').toggle, { desc = 'Toggle [Q]uickfix' })
    vim.keymap.set('n', '<leader>l', function()
      require('quicker').toggle { loclist = true }
    end, { desc = 'Toggle [L]oclist' })
    vim.keymap.set('n', '>', function()
      require('quicker').expand { before = 2, after = 2, add_to_existing = true }
    end, { desc = 'Expand quickfix context' })
    vim.keymap.set('n', '<', function()
      require('quicker').collapse()
    end, { desc = 'Collapse quickfix context' })
  end,
}
