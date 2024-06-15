return {
  "numToStr/Comment.nvim",
  event = "VeryLazy",
  config = function()
    local pre_hook
    local loaded, ts_comment = pcall(require, "ts_context_commentstring.integrations.comment_nvim")
    if loaded and ts_comment then
      pre_hook = ts_comment.create_pre_hook()
    end

    local ft = require("Comment.ft")

    -- 1. Using set function

    ft
      -- Set only line comment
      .set("hurl", "#%s")

    require("Comment").setup({
      ---Add a space b/w comment and the line
      padding = true,

      ---Whether the cursor should stay at its position
      sticky = true,

      ---Lines to be ignored while (un)comment
      ---Lines to be ignored while comment/uncomment.
      ---Could be a regex string or a function that returns a regex string.
      ---Example: Use '^$' to ignore empty lines
      ---@type string|function
      ignore = "^$",

      -- FIX: commented this
      ---LHS of toggle mappings in NORMAL mode
      toggler = {
        ---Line-comment toggle keymap
        line = "gCc",
        ---Block-comment toggle keymap
        block = "gbc",

        -- ---Line-comment toggle keymap
        -- line = "gcc",
        -- ---Block-comment toggle keymap
        -- block = "gbc",
      },

      -- FIX: change this
      ---LHS of operator-pending mappings in NORMAL and VISUAL mode
      opleader = {
        ---Line-comment keymap
        line = "gC",
        -- line = "gc",
        ---Block-comment keymap
        block = "gb",
      },

      ---LHS of extra mappings
      extra = {
        ---Add comment on the line above
        -- above = "gcO",
        above = "gCO",
        ---Add comment on the line below
        below = "gCo",
        -- below = "gco",
        ---Add comment at the end of line
        eol = "gCA",
        -- eol = "gcA",
      },

      ---Enable keybindings
      ---NOTE: If given `false` then the plugin won't create any mappings
      mappings = {
        ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
        basic = true,
        ---Extra mapping; `gco`, `gcO`, `gcA`
        extra = true,
      },

      ---Function to call before (un)comment
      pre_hook = pre_hook,

      ---Function to call after (un)comment
      post_hook = nil,
    })
  end,
}
