return {
  {
    "supermaven-inc/supermaven-nvim",
    event = "VeryLazy",
    build = ":SupermavenUseFree", -- this line is optional, remove if you are using pro
    config = function()
      require("supermaven-nvim").setup({
        keymaps = {
          accept_suggestion = "<C-a>",
          clear_suggestion = "<C-]>",
          -- NOTE: nvim-cmp will take over <c-n> binding in certain situation, so deleting has no effect. us <c-w> instead.
          -- <c-m> also is reserved for 'enter' or <cr>. showkey -a return "<CTL-J=LF>" in both tmux or non. debug this later to make tmux and non to be consistent.
          accept_word = "<C-w>",
        },
        -- ignore_filetypes = { cpp = true },
        color = {
          -- suggestion_color = "#cfcccc",
          -- cterm = 244,
          -- -- NOTE: temp fix. https://github.com/supermaven-inc/supermaven-nvim/pull/53
          suggestion_color = vim.api.nvim_get_hl(0, { name = "NonText" }).fg,
          cterm = vim.api.nvim_get_hl(0, { name = "NonText" }).cterm,
        },
        log_level = "info", -- set to "off" to disable logging completely
        disable_inline_completion = false, -- disables inline completion for use with cmp
        disable_keymaps = false, -- disables built in keymaps for more manual control
      })
      require("supermaven-nvim.completion_preview").suggestion_group = "SupermavenSuggestion"
    end,
  },

  -- supress supermaven log.
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.routes, {
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "Starting Supermaven" },
              { find = "Supermaven Free Tier" },
            },
          },
          skip = true,
        },
      })
    end,
  },
}
