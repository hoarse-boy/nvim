return {
  -- live preview for the custom Norm (norm) command.
  "smjonas/live-command.nvim",
  event = "VeryLazy",
  config = function()
    require("live-command").setup({
      commands = {
        Norm = { cmd = "norm" },
      },
    })
  end,
}
