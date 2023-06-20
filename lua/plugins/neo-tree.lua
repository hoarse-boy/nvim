return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      -- FIX: NOT WORKING
      -- event_handlers = {
      --   {
      --     event = "neo_tree_buffer_enter",
      --     handler = function()
      --       -- This effectively hides the cursor
      --       vim.cmd("highlight! Cursor blend=100")
      --     end,
      --   },
      --   {
      --     event = "neo_tree_buffer_leave",
      --     handler = function()
      --       -- Make this whatever your current Cursor highlight group is.
      --       vim.cmd("highlight! Cursor guibg=#5f87af blend=0")
      --     end,
      --   },
      -- },

      filesystem = {
        window = {
          popup = {
            -- make a float right window
            -- position = { col = "100%", row = "2" },
            position = { col = "-100%", row = "3" }, -- left side floating window
            size = function(state)
              local root_name = vim.fn.fnamemodify(state.path, ":~")
              local root_len = string.len(root_name) + 4
              return {
                width = math.max(root_len, 50),
                height = vim.o.lines - 6,
              }
            end,
          },
        },

        bind_to_cwd = false,
        follow_current_file = true,
      },

      window = {
        position = "float",
        -- position = "left",
        mappings = {
          ["<space>"] = "none",

          -- to make the same behaviour as nvim-tree in lunarvim
          h = function(state)
            local node = state.tree:get_node()
            if (node.type == "directory" or node:has_children()) and node:is_expanded() then
              state.commands.toggle_node(state)
            else
              require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
            end
          end,
          l = "open",
          ["/"] = "none", -- disable native filter of neo-tree. to use vim search instead
        },
      },
    },
  },
}

-- require('neo-tree').setup({
--   event_handlers = {
--     {
--       event = "neo_tree_buffer_enter",
--       handler = function()
--         -- This effectively hides the cursor
--         vim.cmd 'highlight! Cursor blend=100'
--       end
--     },
--     {
--       event = "neo_tree_buffer_leave",
--       handler = function()
--         -- Make this whatever your current Cursor highlight group is.
--         vim.cmd 'highlight! Cursor guibg=#5f87af blend=0'
--       end
--     }
--   },
-- })
