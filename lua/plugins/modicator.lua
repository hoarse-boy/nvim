return {
  "mawkler/modicator.nvim",
  event = "VeryLazy",
  init = function()
    -- These are required for Modicator to work
    vim.o.cursorline = true
    vim.o.number = true
    vim.o.termguicolors = true
  end,
  config = function()
    require("modicator").setup({
      -- Show warning if any required option is missing
      show_warnings = false,
      highlights = {
        -- Default options for bold/italic
        defaults = {
          bold = false,
          italic = true,
        },
      },
    })
  end,
}
