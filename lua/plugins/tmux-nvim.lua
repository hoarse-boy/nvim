return {
  "aserowy/tmux.nvim",
  event = "VeryLazy",
  -- enabled = false, -- disabled plugin
  keys = {
    { "<c-h>", '<cmd>lua require("tmux").move_left()<cr>', mode = "n", desc = "tmux and nvim move left", noremap = true, silent = true },
    { "<c-j>", '<cmd>lua require("tmux").move_bottom()<cr>', mode = "n", desc = "tmux and nvim move bottom", noremap = true, silent = true },
    { "<c-k>", '<cmd>lua require("tmux").move_top()<cr>', mode = "n", desc = "tmux and nvim move top", noremap = true, silent = true },
    { "<c-l>", '<cmd>lua require("tmux").move_right()<cr>', mode = "n", desc = "tmux and nvim move right", noremap = true, silent = true },
  },
  config = function()
    return require("tmux").setup()
  end,
}
