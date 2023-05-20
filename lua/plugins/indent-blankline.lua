return {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    -- char = "▏",
    char = "│",
    filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy" },
    show_trailing_blankline_indent = false,
    -- show_current_context = false,
    show_current_context = true,
    -- show_current_context_start = true,
    show_current_context_start = false,
    space_char_blankline = " ", -- NOTE: i think this make the strange '>' when the window is out of focus from the indent
  },
}
