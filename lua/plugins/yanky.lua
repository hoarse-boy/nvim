return {
  -- better yank/paste
  {
    "gbprod/yanky.nvim",
    dependencies = { { "kkharji/sqlite.lua", enabled = not jit.os:find("Windows") } },
    opts = {
      highlight = { timer = 150 },
      -- ring = { storage = "shada" },
      ring = { storage = jit.os:find("Windows") and "shada" or "sqlite" },
    },
    keys = {
      -- stylua: ignore
      { "<leader>P", "<cmd>YankyRingHistory<CR>", desc = "Open Yank History" }, -- NOTE: use this if below failed again
      -- stylua: ignore
      -- { "<leader>P", function() require("telescope").extensions.yank_history.yank_history({ }) end, desc = "Open Yank History" }, -- TODO: the telescope is getting the same error as before.

      { "y", "<Plug>(YankyYank)", mode = { "n", "x" }, desc = "Yank text" },
      -- { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put yanked text after cursor" }, -- NOTE: disable this as i have add my own custom keymap that make the 'p' to not yank the deleted text when using 'p'.
      -- { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put yanked text before cursor" }, -- NOTE: disable this too. after every yank any keybind listed here will overwrite any keymap in keymaps.lua or any keymaps lua functions.
      { "gp", "<Plug>(YankyGPutAfter)", mode = { "n", "x" }, desc = "Put yanked text after selection" },
      { "gP", "<Plug>(YankyGPutBefore)", mode = { "n", "x" }, desc = "Put yanked text before selection" },
      { "[y", "<Plug>(YankyCycleForward)", desc = "Cycle forward through yank history" },
      { "]y", "<Plug>(YankyCycleBackward)", desc = "Cycle backward through yank history" },
      { "]p", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
      { "[p", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (linewise)" },
      { "]P", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
      { "[P", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (linewise)" },
      { ">p", "<Plug>(YankyPutIndentAfterShiftRight)", desc = "Put and indent right" },
      { "<p", "<Plug>(YankyPutIndentAfterShiftLeft)", desc = "Put and indent left" },
      { ">P", "<Plug>(YankyPutIndentBeforeShiftRight)", desc = "Put before and indent right" },
      { "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)", desc = "Put before and indent left" },
      { "=p", "<Plug>(YankyPutAfterFilter)", desc = "Put after applying a filter" },
      { "=P", "<Plug>(YankyPutBeforeFilter)", desc = "Put before applying a filter" },
    },
  },
}
