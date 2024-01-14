return {
  "lewis6991/gitsigns.nvim",
  event = "LazyFile",
  keys = {
    -- stylua: ignore
    -- there is duplicate keymap to toggle git blame as the other is too deep inside a another prefix 'h'.
    { "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "Toggle Git Blame (virtual text)", mode = "n"  },
  },
}
