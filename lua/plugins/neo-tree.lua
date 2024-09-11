return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    -- enabled = false, -- disabled plugin
    opts = {
      event_handlers = {
        -- auto close when clicking file
        {
          event = "file_opened",
          handler = function(_)
            vim.cmd("Neotree close")
          end,
        },
      },

      filesystem = {
        renderers = {
          file = {
            { "icon" },
            { "name", use_git_status_colors = true },
            { "diagnostics" },
            { "git_status", highlight = "NeoTreeDimText" },
          },
        },

        window = {
          popup = {
            -- make a float right window
            -- position = { col = "100%", row = "2" },
            position = { col = "-100%", row = "3" }, -- left side floating window
            -- size = function(state)
            --   local root_name = vim.fn.fnamemodify(state.path, ":~")
            --   local root_len = string.len(root_name) + 4
            --   return {
            --     width = math.max(root_len, 50),
            --     height = vim.o.lines - 6,
            --   }
            -- end,
          },
        },

        bind_to_cwd = false,
        -- the explorer will show the current / active buffer. even if we use telescope to move to other file it will find it in realtime
        -- NOTE: it will stick like glue to the current / active buffer in neo-tree. but it will not work at all in floating mode
        -- follow_current_file = true,
      },

      commands = {
        -- open dir using os specific app. like macOs open
        -- TODO: find an api to check the current os
        system_open = function(state)
          local node = state.tree:get_node()
          local path = node:get_id()
          -- macOs: open file in default application in the background.
          -- Probably you need to adapt the Linux recipe for manage path with spaces. I don't have a mac to try.
          vim.api.nvim_command("!open -g " .. path)
          -- Linux: open file in default application
          -- vim.api.nvim_command(string.format("silent !xdg-open '%s'", path))
        end,
      },

      window = {
        -- position = "float",
        position = "left", -- NOTE: will use this as default to use follow_current_file behaviour.
        width = 40,
        mappings = {
          ["o"] = "system_open", -- custom command
          ["<space>"] = "none",
          ["/"] = "none", -- disable neo-tree native filter. to use vim search instead. can be used by flash if it is enabled
          -- ["s"] = "none", -- disabled "s" which is the open vsplit. to let the s of "flash" be usefull in searching files

          -- to make the same behaviour as nvim-tree in lunarvim.
          -- move move back to the parent node.
          h = function(state)
            local node = state.tree:get_node()
            if (node.type == "directory" or node:has_children()) and node:is_expanded() then
              state.commands.toggle_node(state)
            else
              require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
            end
          end,
          l = function(state)
            local node = state.tree:get_node()
            if node.type == "directory" or node:has_children() then
              -- If it's a directory, toggle node expansion or focus on its first child
              if not node:is_expanded() then
                state.commands.toggle_node(state)
              else
                require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
              end
            else
              -- If it's a file, open it
              require("neo-tree.sources.filesystem.commands").open(state)
            end
          end,
        },
      },
    },
  },
}
