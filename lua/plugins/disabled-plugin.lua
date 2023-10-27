-- all disabled lazyvim plugins
return {
  {
    -- uses Comment.nvim instead (much smarter)
    "echasnovski/mini.comment",
    enabled = false,
  },

  {
    "echasnovski/mini.surround",
    -- enabled = false, -- NOTE: this is actually decent
  },

  {
    "echasnovski/mini.ai",
    enabled = false, -- disabled plugin
  },

  {
    "folke/trouble.nvim",
    enabled = false,
    keys = {
      -- disable the keymap to grep files
      { "<leader>x", false }, -- NOTE: which key has updated to remove empty keymap
      { "<leader>xl", false },
      { "<leader>xq", false },
      { "<leader>xt", false },
      { "<leader>xT", false },
    },
  },

  -- {
  --   "lewis6991/gitsigns.nvim",
  --   enabled = false,
  -- },
}
