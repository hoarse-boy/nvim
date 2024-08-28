return {
  {
    "johmsalas/text-case.nvim",
    event = "VeryLazy",
    config = function()
      local printf = require("plugins.util.printf").printf

      require("textcase").setup()

      -- TODO: the keymaps are in "ga" find a way to make better?
      require("telescope").load_extension("textcase")
      vim.api.nvim_set_keymap("n", "gaa", "<cmd>TextCaseOpenTelescope<CR>", { desc = printf("Telescope") })
      vim.api.nvim_set_keymap("v", "gai", "<cmd>TextCaseOpenTelescope<CR>", { desc = printf("Telescope") })
      vim.api.nvim_set_keymap("n", "<leader>cN", ":lua require('textcase').lsp_rename('to_constant_case')<CR>", { desc = printf("LSP Rename to Const Case") })
      vim.api.nvim_set_keymap("n", "<leader>cn", ":lua require('textcase').current_word('to_constant_case')<CR>", { desc = printf("Rename to Const Case") })
    end,
  },
  -- {
  --   "folke/which-key.nvim",
  --   opts = function(_, _)
  --     local wk = require("which-key")
  --     local mapping = {
  --       { "ga", group = "text-case", mode = { "n", "x" }, nowait = true, remap = false, ga = nil },
  --       { "gao", group = "Pending mode operator", mode = "n", nowait = true, remap = false },
  --     }
  --     wk.add(mapping)
  --   end,
  -- },
}
