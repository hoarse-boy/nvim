-- all disabled lazyvim plugins
return {
  {
    -- uses Comment.nvim instead (much smarter)
    "echasnovski/mini.comment",
    enabled = false,
  },

  {
    "echasnovski/mini.surround",
    enabled = false,
  },

  -- {
  --   "folke/trouble.nvim",
  --   enabled = false,
  --   keys = {
  --     -- disable the keymap to grep files
  --     { "<leader>x", false }, -- FIX: not working?
  --     { "<leader>xl", false },
  --     { "<leader>xq", false },
  --   },
  -- },

  -- {
  --   "lewis6991/gitsigns.nvim",
  --   enabled = false,
  -- },
}
