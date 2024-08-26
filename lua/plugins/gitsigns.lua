local printf = require("plugins.util.printf").printf

return {
  {
    "lewis6991/gitsigns.nvim",
    event = "LazyFile",
    keys = {
      -- stylua: ignore
      -- there is duplicate keymap to toggle git blame as the other is too deep inside a another prefix 'h'.
      { "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = printf "Toggle Git Blame (virtual text)", mode = "n" },
    },
    opts = function(_, opts)
      -- change the default delay to 0.
      opts.current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 0,
        ignore_whitespace = false,
        virt_text_priority = 100,
        -- current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
      }
    end, -- use this to not overwrite this plugin config (usefull in lazyvim)
  },
}
