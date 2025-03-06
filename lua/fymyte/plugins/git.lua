local autocmd = require('fymyte.utils').autocmd

return {
  ---------------
  ----- Git -----
  ---------------

  -- Git on steroids
  {
    'tpope/vim-fugitive',
    event = 'VeryLazy',
    config = function()
      local function open_fugitive_buf()
        local ok, head = pcall(vim.fn.FugitiveHead)
        if ok and head ~= '' then
          vim.cmd.Git()
        end
      end

      local function get_fugitive_buf()
        return vim.fn.bufnr 'fugitive:///*/.git/{worktrees/*}\\\\\\{0,1\\}/$'
      end

      local function close_fugitive_buf()
        local fugitive_buf = get_fugitive_buf()
        if fugitive_buf ~= -1 then
          vim.api.nvim_buf_delete(fugitive_buf, {})
        end
      end

      function ToggleFugitiveGit()
        local fugitive_buf = get_fugitive_buf()
        if fugitive_buf ~= -1 then
          close_fugitive_buf()
        else
          open_fugitive_buf()
        end
      end

      local fugitive_grp = vim.api.nvim_create_augroup('fugitive_autocmd', { clear = true })
      autocmd('BufReadPost', {
        group = fugitive_grp,
        desc = 'mark fugitive buffers as delete on quit',
        pattern = 'fugitive://*',
        callback = function()
          vim.b.bufhidden = 'delete'
        end,
      })

      autocmd('DirChanged', {
        group = fugitive_grp,
        desc = 'Update fugitive status when changing cwd',
        callback = function()
          close_fugitive_buf()

          -- TODO: currently, opening fugitive buf right here actually make the closing of the previous buffer fail.
        end,
      })

      autocmd('User', {
        group = fugitive_grp,
        desc = 'open commit message in vsplit on the far left',
        pattern = 'FugitiveEditor',
        callback = function()
          vim.cmd.wincmd 'H'
          vim.cmd [[vertical resize 80]]
          vim.cmd.setlocal 'nonumber'
          vim.cmd.setlocal 'norelativenumber'
          vim.cmd.setlocal 'winfixwidth'
        end,
      })

      autocmd('User', {
        group = fugitive_grp,
        pattern = 'FugitiveIndex',
        desc = 'Resize fugigive index window',
        callback = function()
          vim.cmd.resize(10)
          vim.cmd.setlocal 'nonumber'
          vim.cmd.setlocal 'norelativenumber'
          vim.cmd.setlocal 'winfixheight'
        end,
      })
      vim.keymap.set('n', '<leader>tg', ToggleFugitiveGit)
    end,
  },
  -- Easy worktree management
  {
    'polarmutex/git-worktree.nvim',
    config = function(_, _)
      local hooks = require 'git-worktree.hooks'
      local config = require 'git-worktree.config'

      if pcall(require, 'telescope') then
        require('telescope').load_extension 'git_worktree'
        vim.keymap.set(
          'n',
          '<leader>sw',
          require('telescope').extensions.git_worktree.git_worktree,
          { noremap = true, silent = true, desc = '[S]earch Git [W]orktree' }
        )
      end

      hooks.register(hooks.type.SWITCH, hooks.builtins.update_current_buffer_on_switch)
      hooks.register(hooks.type.DELETE, config.update_on_change_command)
    end,
  },
  -- GitHub/GitLab in neovim
  { 'tpope/vim-rhubarb', enabled = false },
  -- Git hunks displayed inline
  {
    'lewis6991/gitsigns.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    event = 'BufReadPre',
    opts = {
      on_attach = function(bufnr)
        local gs = require 'gitsigns'
        local opts = { noremap = true, silent = true }
        local function map(mode, l, r, lopts)
          lopts = vim.tbl_extend('force', opts, lopts or {})
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
        map('n', '<leader>thb', gs.toggle_current_line_blame, { desc = '[T]oggle [H]unk [B]lame' })
        map('n', '<leader>hd', gs.diffthis, { desc = '[H]unk [D]iff index' })
        map('n', '<leader>hD', function()
          gs.diffthis '~'
        end, { desc = '[H]unk [D]iff last commit' })
        map('n', '<leader>thd', gs.preview_hunk_inline, { desc = '[T]oggle [H]unk [D]eleted lines' })
      end,
      preview_config = {
        border = 'rounded',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1,
      },
    },
  },

  {
    'harrisoncramer/gitlab.nvim',
    -- Only if we have go installed, to not have error on startup
    cond = function()
      return vim.fn.executable 'go' == 1
    end,
    enabled = true,
    dependencies = {
      'MunifTanjim/nui.nvim',
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
      'stevearc/dressing.nvim', -- Recommended but not required. Better UI for pickers.
    },
    build = function()
      require('gitlab.server').build(true)
    end,
    opts = {
      keymaps = {
        discussion_tree = {
          toggle_node = '<cr>',
        },
        popup = {
          perform_action = '<leader>w',
          discard_changes = 'q',
        },
      },
      reviewer_settings = {
        diffview = {
          imply_local = true,
        },
      },
      popup = {
        border = 'solid',
        temp_registers = { '"', '+', 'g' },
      },
      discussion_tree = {
        size = '15%',
      },
    },
    config = true,
  },
}
