return {
  {
    "ecthelionvi/NeoComposer.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>M", "<cmd>Telescope macros<cr>", desc = "NeoComposer (macro)" },
    },
    dependencies = { "kkharji/sqlite.lua", "nvim-telescope/telescope.nvim" },
    config = function(_, opts)
      require("NeoComposer").setup({
        keymaps = {
          play_macro = "Q",
          yank_macro = "yq",
          stop_macro = "cq",
          toggle_record = "q",
          cycle_next = "gqn", -- NOTE: disable it the default c-n as it is used by supermaven.
          cycle_prev = "gqp",
          toggle_macro_menu = "<m-q>",
        },
      })
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
