return {
  "folke/todo-comments.nvim",
  opts = function(_, opts)
    opts.merge_keywords = true -- when true, custom keywords will be merged with the defaults

    -- add my custom todo.
    opts.keywords = {
      MARKED = {
        icon = " 󰓾", -- " 󰣉"
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
  },

  {
    "folke/which-key.nvim",
    opts = function(_, _)
      local wk = require("which-key")
      local keymaps = {
        mode = { "n" },
        ["<leader>m"] = { name = "+mark" },
      }
      wk.register(keymaps, opts)
    end,
  },
}
