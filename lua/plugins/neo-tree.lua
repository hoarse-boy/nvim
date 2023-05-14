return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = true,
      },
      window = {
        position = "float",
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
