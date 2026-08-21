local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

vim.pack.add {
  Utils.gh 'folke/snacks.nvim',
  Utils.gh 'Juksuu/worktrees.nvim',
}

require('snacks').setup {
  bigfile = { enabled = true },
  input = { prompt_pos = 'left', win = { relative = 'cursor', width = 40 } },
  picker = {
    layout = function(source)
      return source == 'select' and 'select' or 'default_reverse'
    end,
    layouts = {
      default_reverse = {
        reverse = true,
        layout = {
          box = 'horizontal',
          width = 0.8,
          min_width = 120,
          height = 0.8,
          {
            box = 'vertical',
            border = true,
            title = '{title} {live} {flags}',
            { win = 'list', border = 'none' },
            { win = 'input', height = 1, border = 'top' },
          },
          { win = 'preview', title = '{preview}', border = true, width = 0.5 },
        },
      },
    },
  },
  terminal = {
    shell = 'fish',
    win = { position = 'right', width = 0.4 },
  },
}

--- @type snacks.win[]
local last_showned = {}

--- Snacks terminals except the Claude Code one: claudecode.nvim uses the Snacks provider,
--- so its terminal shows up in `Snacks.terminal.list()` too, and it has its own <M-o>.
--- @return snacks.win[]
local function shell_terminals()
  local ok, claude_term = pcall(require, 'claudecode.terminal')
  local claude_buf = ok and claude_term.get_active_terminal_bufnr() or nil
  return vim.tbl_filter(function(t)
    return t.buf ~= claude_buf
  end, Snacks.terminal.list())
end

vim.keymap.set({ 'n', 't' }, '<M-i>', function()
  local terms = shell_terminals()
  local visible_terms = vim.tbl_filter(function(t)
    return t:valid()
  end, terms)

  if vim.v.count ~= 0 or #terms == 0 then
    last_showned = visible_terms
    -- Use default behavior if one term is selected: toggle the targeted term
    Snacks.terminal.toggle()
    return
  end

  if visible_terms and #visible_terms > 0 then
    last_showned = visible_terms
    for i, t in ipairs(visible_terms) do
      t:hide()
    end
  elseif #last_showned > 0 then
    for _, t in ipairs(last_showned) do
      t:show()
    end
  else
    for i, _ in ipairs(terms) do
      Snacks.terminal.focus({}, { count = i })
    end
  end
end)

require('worktrees').setup {}

autocmd('User', {
  group = augroup('LspHandleFileRename', { clear = true }),
  pattern = 'OilActionsPost',
  callback = function(event)
    for _, action in pairs(event.data.actions) do
      if action.type == 'move' then
        Snacks.rename.on_rename_file(action.src_url, action.dest_url)
      end
    end
  end,
})

local keys = {
  { '<leader>sf', Snacks.picker.files, desc = '[S]earch [F]ile' },
  { '<leader>sh', Snacks.picker.help, desc = '[S]earch [H]elp' },
  { '<leader>sr', Snacks.picker.registers, desc = '[S]earch [R]egister' },
  { '<leader>sb', Snacks.picker.buffers, desc = '[S]earch [B]uffer' },
  { '<leader>ss', Snacks.picker.grep_word, desc = '[S]earch [S]tring' },
  { '<leader>sg', Snacks.picker.grep, desc = '[S]earch [G]rep' },
  { '<leader>sk', Snacks.picker.keymaps, desc = '[S]earch [K]eymap' },
  { '<leader>sc', Snacks.picker.autocmds, desc = '[S]earch [C]ommands' },
  { '<leader>sl', Snacks.picker.lines, desc = '[S]earch [L]ines' },
  ---@diagnostic disable-next-line:undefined-field
  { '<leader>sw', Snacks.picker.worktrees, desc = '[S]earch Git [W]orktrees' },

  { '<leader>cb', Snacks.picker.git_branches, desc = '[C]hange Git [B]ranch' },
}
for _, v in pairs(keys) do
  vim.keymap.set('n', v[1], v[2], { desc = v.desc })
end

vim.api.nvim_create_user_command('Pick', function(args)
  Snacks.picker.pick(args.args)
end, {
  nargs = '?',
  desc = 'Snacks Pickers',
  complete = function(lead, cmd, pos)
    local res = {}
    for k, _ in pairs(Snacks.picker) do
      if #lead == 0 or k.sub(1, #lead) == lead then
        table.insert(res, k)
      end
    end

    return res
  end,
})
