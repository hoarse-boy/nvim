return {
  {
    "supermaven-inc/supermaven-nvim",
    event = "VeryLazy",
    config = function()
      require("supermaven-nvim").setup({
        keymaps = {
          accept_suggestion = "<C-a>",
          clear_suggestion = "<C-]>",
          accept_word = "<C-n>",
        },
        -- ignore_filetypes = { cpp = true },
        color = {
          -- suggestion_color = "#cfcccc",
          -- cterm = 244,
          -- -- NOTE: temp fix. https://github.com/supermaven-inc/supermaven-nvim/pull/53
          suggestion_color = vim.api.nvim_get_hl(0, { name = "NonText" }).fg,
          cterm = vim.api.nvim_get_hl(0, { name = "NonText" }).cterm,
        },
        log_level = "info",                -- set to "off" to disable logging completely
        disable_inline_completion = false, -- disables inline completion for use with cmp
        disable_keymaps = false,           -- disables built in keymaps for more manual control
      })
      require("supermaven-nvim.completion_preview").suggestion_group = "SupermavenSuggestion"
    end,
  },
  {},
}
