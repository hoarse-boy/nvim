return {
  "akinsho/bufferline.nvim",
  opts = function(_, opts)
    opts.options = {

      diagnostics = "nvim_lsp",
      indicator = {
        icon = "", -- this should be omitted if indicator style is not 'icon'
        style = "underline", -- "icon" | "underline" | "none",
      },

      always_show_bufferline = true,
      show_buffer_close_icons = false,
      show_close_icon = true,
      -- hover = {
      --   enabled = true,
      --   delay = 200,
      --   reveal = { "close" },
      -- },
      separator_style = { "", "" }, -- use this to remove the buggy lazyvim separator. ex. "slant" | "slope" | "thick" | "thin" | { "any", "any" }
    }

    require("bufferline").setup(opts)
  end,
}
