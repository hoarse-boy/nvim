-- put all other plugins that do not need any major code setup

return {
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

  -- live preview for the custom Norm (norm) command.
  {
    "smjonas/live-command.nvim",
    event = "VeryLazy",
    config = function()
      require("live-command").setup({
        commands = {
          Norm = { cmd = "norm" },
        },
      })
    end,
  },
}
