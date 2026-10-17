vim.pack.add { Utils.gh 'willothy/flatten.nvim' }

---Terminal hidden for the duration of an edit, waiting to be put back. flatten only
---supports one blocking guest at a time (it recreates its `flatten_notify` augroup per
---edit), so a single slot is all that is meaningful.
---@type snacks.win | nil
local hidden_term = nil

---Terminal whose window we split, plus the width that window had, recorded by
---`window.open` and consumed by `post_open`.
---@type { term: snacks.win, width: number } | nil
local pending = nil

local augroup = vim.api.nvim_create_augroup('FlattenRestoreTerm', { clear = true })

---@param buf integer
---@return snacks.win?
local function find_term(buf)
  for _, term in ipairs(Snacks.terminal.list()) do
    if term.buf == buf then
      return term
    end
  end
  return nil
end

---Snacks terminal shown in the focused window, if any.
---@return snacks.win?
local function focused_term()
  local term = find_term(vim.api.nvim_get_current_buf())
  if term and term:win_valid() then
    return term
  end
  return nil
end

---Put back the terminal we hid, if any. Idempotent: the slot is cleared first, so all the
---triggers wired in `post_open` can fire without fighting each other.
local function restore_term()
  local term = hidden_term
  hidden_term = nil
  if not term then
    return
  end
  -- Callers include `block_end` (which flatten calls from inside QuitPre/BufUnload) where
  -- window APIs are refused under |textlock|.
  vim.schedule(function()
    if term:buf_valid() then
      term:show()
      term:focus()
    end
  end)
end

require('flatten').setup {
  window = {
    open = function(opts)
      ---@as table<string,string>
      local to_focus = opts.stdin_buf or opts.files[1] or { bufnr = 0, file = nil }

      -- Replace the terminal window
      local term = focused_term()
      pending = term
          and {
            term = term,
            width = vim.api.nvim_win_get_width(term.win--[[@as integer]]),
          }
        or nil

      local winnr = vim.api.nvim_open_win(to_focus.bufnr, true, {
        split = 'left',
        win = term and term.win or 0, ---@as integer
      })
      return to_focus.bufnr, winnr
    end,
  },
  hooks = {
    ---@param opts Flatten.PostOpenContext
    post_open = function(opts)
      local state = pending
      pending = nil

      if vim.api.nvim_win_is_valid(opts.winnr) then
        vim.api.nvim_set_current_win(opts.winnr)
      end

      if not state then
        return
      end
      if hidden_term and hidden_term ~= state.term then
        restore_term()
      end

      state.term:hide()
      hidden_term = state.term

      -- 'equalalways' redistributes width across every window when the terminal's one
      -- closes, which would shrink the window we were not asked to touch. Pin this one
      -- back to exactly the slot the terminal was using.
      pcall(vim.api.nvim_win_set_width, opts.winnr, state.width)

      -- `block_end` only fires for a blocking edit, and only on the buffer going away.
      -- Cover the non-blocking case, plus `:close` (window gone, buffer still loaded).
      vim.api.nvim_clear_autocmds { group = augroup }
      vim.api.nvim_create_autocmd('WinClosed', {
        group = augroup,
        pattern = tostring(opts.winnr),
        once = true,
        callback = restore_term,
      })
      vim.api.nvim_create_autocmd({ 'BufUnload', 'BufDelete' }, {
        group = augroup,
        buffer = opts.bufnr,
        once = true,
        callback = restore_term,
      })
    end,

    block_end = restore_term,
  },
}
