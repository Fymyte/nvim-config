return  {
  -- Comment.nivm -- Smart comments
  {
    'numtostr/comment.nvim', -- Smart comments
    opts = {
      -- Ignore empty lines when commenting (could be a function too)
      ignore = '^$',
      ---LHS of toggle mappings in NORMAL + VISUAL mode
      toggler = {
        line = 'gcc',
        block = 'gbc',
      },
      opleader = {
        line = 'gc',
        block = 'gb',
      },

      extra = {
        above = 'gcO', -- Add comment on the line above
        below = 'gco', -- Add comment on the line below
        eol = 'gcA', -- Add comment at the end of line
      },

      ---Create basic (operator-pending) and extended mappings for NORMAL + VISUAL mode
      ---NOTE: If `mappings = false` then the plugin won't create any mappings
      ---@type boolean|table
      mappings = {
        ---Operator-pending mapping
        ---Includes `gcc`, `gbc`, `gc[count]{motion}` and `gb[count]{motion}`
        ---NOTE: These mappings can be changed individually by `opleader` and `toggler` config
        basic = true,
        ---Extra mapping
        ---Includes `gco`, `gcO`, `gcA`
        extra = true,
        ---Extended mapping
        ---Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
        extended = false,
      },

      ---Pre-hook, called before commenting the line
      ---@type fun(ctx: CommentCtx):string
      pre_hook = nil,

      ---Post-hook, called after commenting is done
      ---@type fun(ctx: CommentCtx)
      post_hook = nil,

    },
  }
}
