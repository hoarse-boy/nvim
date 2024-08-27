local printf = require("plugins.util.printf").printf

return {
  "sindrets/diffview.nvim",
  event = "VeryLazy",
  enabled = false, -- disabled plugin -- FIX: test which plugin causes the slow quit nvim.
  -- dependencies = {},
  -- init = function() end, -- functions are always executed during startup
  -- opts = function(_, opts) end, -- use this to not overwrite this plugin config (usefull in lazyvim)
  keys = {
    -- { "<leader>l", "", desc = printf"+go.nvim" }, -- example
    -- { "<leader>ls", "<cmd>GoFillStruct<cr>", desc = printf"Fill Struct" }, -- example
    -- { "<s-tab>", function() require("luasnip").jump(-1) end,  mode = { "i", "s" }, desc = printf"luasnip tab", noremap = true, silent = true },
    -- { "define keymaps", "what the keys do", desc = printf"description", mode = "vim mode" }
  },
  config = function()
    require("diffview").setup()
  end,
}
