local isLspStart = false

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      event_handlers = {
        -- auto close when clicking file
        {
          event = "file_opened",
          handler = function(_)
            -- require("neo-tree").close() -- NOTE: not working after 1.3
            vim.cmd("Neotree close")
          end,
        },

        -- FIX: delete later. not really impactfull
        -- {
        --   event = "after_render",
        --   handler = function()
        --     if isLspStart == false then
        --       isLspStart = true
        --       -- TODO: find a way to store some value in a array of string and then be required here
        --       -- for now only check for go and rust files to start their lsp on local var in this module
        --       -- -- FIX: rust_analyzer is not working? need to have single file true? need to uninstall and use mason only dir?
        --       -- or use root dir to have neo tree like go?
        --       local ok, lspList = pcall(require, "plugins.extras.lang")
        --       if ok then
        --         for key, value in pairs(lspList[1]) do
        --           local findFile = vim.fn.findfile(value, ".;")
        --           if findFile == value then
        --             local vimCmd = string.format("LspStart %s", key)
        --             vim.cmd(vimCmd)
        --             break
        --           end
        --         end
        --       end
        --     end
        --     -- -- TODO:
        --     -- afer render is not one time. make it one time only
        --     -- TODO: add logic to handle this and move to go.lua
        --     -- create for rust and other
        --     -- require("neo-tree.sources.filesystem").reset_search(state)
        --   end,
        -- },
      },

      filesystem = {
        -- harpoon_index
        components = {
          harpoon_index = function(config, node, state)
            local Marked = require("harpoon.mark")
            local path = node:get_id()
            local is_succes, index = pcall(Marked.get_index_of, path)
            if is_succes and index and index > 0 then
              return {
                text = string.format(" ⥤ %d", index), -- <-- Add your favorite harpoon like arrow here
                highlight = config.highlight or "NeoTreeDirectoryIcon",
              }
            else
              return {}
            end
          end,
        },
        renderers = {
          file = {
            { "icon" },
            { "name", use_git_status_colors = true },
            { "harpoon_index" },
            { "diagnostics" },
            { "git_status", highlight = "NeoTreeDimText" },
          },
        },

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
        -- the explorer will show the current / active buffer. even if we use telescope to move to other file it will find it in realtime
        -- NOTE: it will stick like glue to the current / active buffer in neo-tree. but it will not work at all in floating mode
        follow_current_file = true,
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
        position = "left", -- NOTE: will use this as default to use follow_current_file behaviour. but the downside is. when dap-ui is active it will make the window behave strangely everytime the neo-tree is expanded
        width = 40,
        mappings = {
          ["o"] = "system_open", -- custom command
          ["<space>"] = "none",
          -- ["s"] = "none", -- disabled "s" which is the open vsplit. to let the s of "flash" be usefull in searching files

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
          ["/"] = "none", -- disable native filter of neo-tree. to use vim search instead. can be used by flash if it is enabled
        },
      },
    },
  },
}
