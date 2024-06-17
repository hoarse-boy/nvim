return{
  {
    "supermaven-inc/supermaven-nvim",
    event = "VeryLazy",
    config = function()
      require("supermaven-nvim").setup({
        keymaps = {
          accept_suggestion = "<C-a>",
          clear_suggestion = "<C-]>",
          accept_word = "<C-l>",
        },
        -- ignore_filetypes = { cpp = true },
        color = {
          suggestion_color = "#cfcccc",
          cterm = 244,
        },
        log_level = "info", -- set to "off" to disable logging completely
        disable_inline_completion = false, -- disables inline completion for use with cmp
        disable_keymaps = false, -- disables built in keymaps for more manual control
      })
    end,
  }
}
