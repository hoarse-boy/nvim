return {
  "folke/todo-comments.nvim",
  opts = function(_, opts)
    opts.merge_keywords = true -- when true, custom keywords will be merged with the defaults

    -- add my custom todo.
    opts.keywords = {
      MARKED = {
        icon = "󰓾", -- "󰣉"
        color = "mark",
        -- signs = false, -- configure signs for some keywords individually
      },
    }

    opts.colors = { mark = { "marked-hl", "#d0d2d6" } }
  end,
  keys = {
    {
      "<leader>mm",
      function()
        require("plugins.util.custome_todo_comments").insert_custom_todo_comments()
      end,
      mode = "n",
      desc = "Insert MARKED todo",
      noremap = true,
      silent = true,
    },
    {
      "<leader>mf", -- TODO: change the insert_custom_todo_comments func to not add new line but add to the right as comments? if lang is not availabl, create new line.
      function()
        require("plugins.util.custome_todo_comments").insert_custom_todo_comments("FIX: ")
      end,
      mode = "n",
      desc = "Insert FIXED todo",
      noremap = true,
      silent = true,
    },
    {
      "<leader>mt",
      "<cmd>TodoTelescope keywords=MARKED<cr>",
      mode = "n",
      desc = "Telescope Open 'MARKED' Todo",
      noremap = true,
      silent = true,
    },
    {
      "<leader>mT",
      "<cmd>Trouble todo filter = {tag = {MARKED}}<cr>",
      mode = "n",
      desc = "Trouble Open 'MARKED' Todo",
      noremap = true,
      silent = true,
    },
    {
      "<leader>mF",
      "<cmd>Trouble todo filter = {tag = {FIX}}<cr>",
      mode = "n",
      desc = "Trouble Open 'FIX' Todo",
      noremap = true,
      silent = true,
    },
  },

  -- NOTE: this is not working. but the same code in harppon works. why?
  -- {
  --   "folke/which-key.nvim",
  --   opts = function(_, opts)
  --       local wk = require("which-key")
  --       local keymaps = {
  --         mode = { "n" },
  --         ["<leader>m"] = { name = "+mark" },
  --       }
  --       wk.register(keymaps, opts)
  --   end,
  -- },
}
