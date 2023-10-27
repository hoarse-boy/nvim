-- put all other plugins that do not need any major code setup

return {
  -- { "nvim-treesitter/nvim-treesitter-context" }, -- cannot use the plugin when it uses event = "VeryLazy"
  -- { "mg979/vim-visual-multi" },
  -- {
  --   "instant-markdown/vim-instant-markdown",
  --   event = "VeryLazy",
  -- },

  {
    "nvim-pack/nvim-spectre",
    keys = {
      {
        "<leader>sf",
        '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
        desc = "Search on current file",
      },
    },
  },
}
