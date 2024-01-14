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
    -- enabled = false, -- disabled plugin
    event = "VeryLazy",
    keys = {
      -- { "<leader>l", "", desc = "+go.nvim" }, -- example
      -- { "<leader>ls", "<cmd>GoFillStruct<cr>", desc = "Fill Struct" }, -- example
      { "define keymaps", "what the keys do", desc = "description" },
    },
    config = function(_, opts)
      if not vim.g.neovide then
        local animate = require("mini.animate")

        animate.setup({
          -- Cursor path
          cursor = {
            enable = true,
            -- Timing of animation (how steps will progress in time)
            -- timing = --<function: implements linear total 250ms animation duration>,
            -- Path generator for visualized cursor movement
            -- path = --<function: implements shortest line path>,
          },

          -- Vertical scroll
          scroll = {
            enable = true,
            -- timing = animate.gen_timing.cubic({ duration = 20, unit = "total" }),
            timing = animate.gen_timing.linear({ duration = 10, unit = "total" }),

            -- Animate equally but with at most 120 steps instead of default 60
            subscroll = animate.gen_subscroll.equal({ max_output_steps = 10 }),
            -- subscroll = animate.gen_subscroll.equal({ max_output_steps = 120 }),
          },

          -- Window resize
          resize = {
            -- Whether to enable this animation
            enable = disable,

            -- Timing of animation (how steps will progress in time)
            -- timing = --<function: implements linear total 250ms animation duration>,

            -- Subresize generator for all steps of resize animations
            -- subresize = --<function: implements equal linear steps>,
          },

          -- Window open
          open = {
            enable = false,

            -- Timing of animation (how steps will progress in time)
            -- timing = --<function: implements linear total 250ms animation duration>,

            -- Floating window config generator visualizing specific window
            -- winconfig = --<function: implements static window for 25 steps>,

            -- 'winblend' (window transparency) generator for floating window
            -- winblend = --<function: implements equal linear steps from 80 to 100>,
          },

          -- Window close
          close = {
            -- Whether to enable this animation
            enable = false, -- NOTE: disable this to remove the ugly black bg hl when closing neo-tree

            -- Timing of animation (how steps will progress in time)
            -- timing = --<function: implements linear total 250ms animation duration>,

            -- Floating window config generator visualizing specific window
            -- winconfig = --<function: implements static window for 25 steps>,

            -- 'winblend' (window transparency) generator for floating window
            -- winblend = --<function: implements equal linear steps from 80 to 100>,
          },
        })

        -- TODO: current issue is when press and hold c-d or c-u it will have strange animation.
        -- find the cause and fix / report it.

        -- vim.keymap.set(
        --   "n",
        --   "<C-d>",
        --   [[<Cmd>lua vim.cmd('normal! <C-d>'); MiniAnimate.execute_after('scroll', 'normal! zvzz')<CR>]]
        -- )
        -- vim.keymap.set(
        --   "n",
        --   "<C-u>",
        --   [[<Cmd>lua vim.cmd('normal! <C-u>'); MiniAnimate.execute_after('scroll', 'normal! zvzz')<CR>]]
        -- )
      end
    end,
  },
}
