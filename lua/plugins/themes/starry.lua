return {
  {
    "ray-x/starry.nvim",
    -- lazy = false, -- make sure we load this during startup if it is your main colorscheme
    -- priority = 1000, -- make sure to load this before all the other start plugins
    event = "VeryLazy",
    config = function()
      -- see example setup below
      vim.g.starry_italic_comments = true
      vim.g.starry_disable_background = true
      vim.g.starry_style = "early_summer"
    end,
  },
}
