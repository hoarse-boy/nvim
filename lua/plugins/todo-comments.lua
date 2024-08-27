local printf = require("plugins.util.printf").printf

-- other keymaps for marking buffer are here.
return {
  {
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
          require("plugins.util.custom_todo_comments").insert_custom_todo_comments()
        end,
        mode = "n",
        desc = printf("Insert MARKED todo"),
        noremap = true,
        silent = true,
      },
      {
        "<leader>mf", -- TODO: change the insert_custom_todo_comments func to not add new line but add to the right as comments? if lang is not availabl, create new line.
        function()
          require("plugins.util.custom_todo_comments").append_todo_comments_to_current_line("FIX: ", true)
        end,
        mode = "n",
        desc = printf("Insert FIXED todo"),
        noremap = true,
        silent = true,
      },
      -- TODO: change todo telescopt and trouble.
      -- for example make 'mt' to be regular tele to search MARKED.
      -- but make mT to be telescopte to show selection first such as 'MARKED' and then 'FIXED' and search using telescope.
      {
        "<leader>mt",
        "<cmd>TodoTelescope keywords=MARKED<cr>",
        mode = "n",
        desc = printf("Telescope Open 'MARKED' Todo"),
        noremap = true,
        silent = true,
      },
      {
        "<leader>mT",
        "<cmd>Trouble todo filter = {tag = {MARKED}}<cr>",
        mode = "n",
        desc = printf("Trouble Open 'MARKED' Todo"),
        noremap = true,
        silent = true,
      },
      {
        "<leader>mF",
        "<cmd>Trouble todo filter = {tag = {FIX}}<cr>",
        mode = "n",
        desc = printf("Trouble Open 'FIX' Todo"),
        noremap = true,
        silent = true,
      },
    },
  },

  {
    "folke/which-key.nvim",
    opts = function(_, _)
      local wk = require("which-key")
      local mapping = {
        { "<leader>m", icon = "󰓾", group = printf("todo marker"), mode = "n" },
      }
      wk.add(mapping)
    end,
  },
}
