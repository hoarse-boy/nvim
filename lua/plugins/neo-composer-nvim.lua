return {
  "ecthelionvi/NeoComposer.nvim",
  event = "VeryLazy",
  dependencies = { "kkharji/sqlite.lua", "nvim-telescope/telescope.nvim" },
  config = function(_, opts)
    require("NeoComposer").setup()
    require("telescope").load_extension("macros")
  end,
}
