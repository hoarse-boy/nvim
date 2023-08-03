return {
  "johmsalas/text-case.nvim",
  -- enabled = false, -- disabled plugin
  event = "VeryLazy",
  config = function()
    require("textcase").setup()

    -- TODO: the keymaps are in "ga" find a way to make better?
    require("telescope").load_extension("textcase")
    vim.api.nvim_set_keymap("n", "gaa", "<cmd>TextCaseOpenTelescope<CR>", { desc = "Telescope" })
    vim.api.nvim_set_keymap("v", "gai", "<cmd>TextCaseOpenTelescope<CR>", { desc = "Telescope" })
  end,
}
