return {
  "johmsalas/text-case.nvim",
  event = "VeryLazy",
  config = function()
    require("textcase").setup()

    -- TODO: the keymaps are in "ga" find a way to make better?
    require("telescope").load_extension("textcase")
    vim.api.nvim_set_keymap("n", "gaa", "<cmd>TextCaseOpenTelescope<CR>", { desc = "Telescope" })
    vim.api.nvim_set_keymap("v", "gai", "<cmd>TextCaseOpenTelescope<CR>", { desc = "Telescope" })
    vim.api.nvim_set_keymap(
      "n",
      "<leader>cN",
      ":lua require('textcase').lsp_rename('to_constant_case')<CR>",
      { desc = "LSP Rename to Const Case" }
    )
    vim.api.nvim_set_keymap(
      "n",
      "<leader>cn",
      ":lua require('textcase').current_word('to_constant_case')<CR>",
      { desc = "Rename to Const Case" }
    )
  end,
}
