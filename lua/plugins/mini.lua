return {
  {
    "echasnovski/mini.operators",
    version = "*",
    event = "VeryLazy",
    config = function(_, _)
      require("mini.operators").setup({
        -- Each entry configures one operator.
        -- `prefix` defines keys mapped during `setup()`: in Normal mode
        -- to operate on textobject and line, in Visual - on selection.

        -- Evaluate text and replace with output
        evaluate = {
          prefix = "g=",

          -- Function which does the evaluation
          func = nil,
        },

        -- Exchange text regions
        exchange = {
          prefix = "gx",

          -- Whether to reindent new text to match previous indent
          reindent_linewise = true,
        },

        -- Multiply (duplicate) text
        multiply = {
          prefix = "gm",

          -- Function which can modify text before multiplying
          func = nil,
        },

        -- Replace text with register
        replace = {
          prefix = "gr",

          -- Whether to reindent new text to match previous indent
          reindent_linewise = true,
        },

        -- Sort text
        sort = {
          prefix = "gS",

          -- Function which does the sort
          func = nil,
        },
      })
    end,
  },

  -- dont use cinnamon.nvim as it has a fatal flaw that make the input to not be stop even pressing escape, causing the animation to only finish when the scroll is done.
  {
    "echasnovski/mini.animate",
    version = false,
    enabled = false, -- disabled plugin
    event = "VeryLazy",
    config = function(_, _)
      if not vim.g.neovide then
        local animate = require("mini.animate")

        animate.setup({
          -- Cursor path
          cursor = {
            enable = false,
            -- timing = animate.gen_timing.linear({ duration = 20, unit = "total" }),
          },

          -- Vertical scroll
          scroll = {
            -- TODO: known bug, when navigating in a big file mini.animate will make the navigation looks very sluggish.
            -- the current solution is to press any key again after pressing vim movement keys.
            -- ex. gg or G, pres k for example to make it finish the animation.
            -- NOTE: lowering the duration will not fix it. disable the plugin will.
            enable = true,
            -- timing = animate.gen_timing.linear({ duration = 60, unit = "total" }),
            timing = animate.gen_timing.linear({ duration = 20, unit = "total" }),
            -- timing = animate.gen_timing.linear({ duration = 10, unit = "total" }),
            -- Animate equally but with at most 120 steps instead of default 60
            subscroll = animate.gen_subscroll.equal({ max_output_steps = 40 }),
            -- subscroll = animate.gen_subscroll.equal({ max_output_steps = 100 }),
            -- subscroll = animate.gen_subscroll.equal({ max_output_steps = 25 }),
            -- subscroll = animate.gen_subscroll.equal({ max_output_steps = 120 }),
          },

          -- Window resize
          resize = {
            enable = false,
          },

          -- Window open
          open = {
            enable = false,
          },

          -- Window close
          close = {
            enable = false, -- NOTE: disable this to remove the ugly black bg hl when closing neo-tree
          },
        })
      end
    end,
  },
}
