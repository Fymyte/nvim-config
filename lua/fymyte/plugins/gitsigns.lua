---@type LazyPluginSpec
return {
  'lewis6991/gitsigns.nvim',
  dependencies = 'nvim-lua/plenary.nvim',
  event = 'BufReadPre',
  opts = {
    on_attach = function(bufnr)
      local gs = require 'gitsigns'
      local function map(mode, l, r, lopts)
        lopts = vim.tbl_extend('force', { noremap = true, silent = true }, lopts or {})
        lopts.buffer = bufnr
        vim.keymap.set(mode, l, r, lopts)
      end

      -- Navigation
      map('n', ']c', function()
        if vim.wo.diff then
          vim.cmd.normal { ']c', bang = true }
        else
          gs.nav_hunk 'next'
        end
      end, { desc = 'Next [C]hange' })

      map('n', '[c', function()
        if vim.wo.diff then
          vim.cmd.normal { '[c', bang = true }
        else
          gs.nav_hunk 'prev'
        end
      end, { desc = 'Prev [C]hange' }) -- Actions

      map('n', '<leader>hs', gs.stage_hunk, { desc = '[H]unk [S]tage/Un[S]tage' })
      map('v', '<leader>hs', function()
        gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, { desc = '[H]unk [S]tage/Un[S]tage' })
      map('n', '<leader>hr', gs.reset_hunk, { desc = '[H]unk [R]eset' })
      map('v', '<leader>hr', function()
        gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, { desc = '[H]unk [R]eset' })

      map('n', '<leader>hS', gs.stage_buffer, { desc = '[H]unk [S]tage buffer' })
      map('n', '<leader>hR', gs.reset_buffer, { desc = '[H]unk [R]eset buffer' })
      map('n', '<leader>hp', gs.preview_hunk, { desc = '[H]unk [P]review' })
      map('n', '<leader>hb', function()
        gs.blame_line { full = true }
      end, { desc = '[H]unk [B]lame' })
      map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = '[T]oggle [H]unk [B]lame' })
      map('n', '<leader>hd', gs.diffthis, { desc = '[H]unk [D]iff index' })
      map('n', '<leader>hD', function()
        gs.diffthis '~'
      end, { desc = '[H]unk [D]iff last commit' })
      map('n', '<leader>thi', gs.preview_hunk_inline, { desc = '[T]oggle [H]unk [D]eleted lines' })

      -- Add hunk text object
      map({ 'o', 'x' }, 'ih', gs.select_hunk, { desc = '[I]nside [H]unk' })
    end,

    preview_config = {
      style = 'minimal',
      relative = 'cursor',
      row = 0,
      col = 1,
    },
  },
}
