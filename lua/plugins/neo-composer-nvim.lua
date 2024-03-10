return {
  {
    "ecthelionvi/NeoComposer.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>m", "<cmd>Telescope macros<cr>", desc = "NeoComposer (macro)" },
    },
    dependencies = { "kkharji/sqlite.lua", "nvim-telescope/telescope.nvim" },
    config = function(_, opts)
      require("NeoComposer").setup()
      require("telescope").load_extension("macros")
    end,
  },

  -- FIX: not working.
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, 2, require("NeoComposer.ui").status_recording)
    end,
  },
}
