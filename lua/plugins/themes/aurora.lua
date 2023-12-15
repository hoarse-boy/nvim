return {
  "ray-x/aurora",
  -- enabled = false, -- disabled plugin
  -- lazy = false, -- make sure we load this during startup if it is your main colorscheme
  -- priority = 1000, -- make sure to load this before all the other start plugins
  event = "VeryLazy",
  config = function()
    -- Default options:
    -- require("aurora").setup()
    vim.g.aurora_transparent = true
  end,
}
