return {
  "stefanlogue/hydrate.nvim",
  event = "VeryLazy",
  -- enabled = false, -- disabled plugin
  -- dependencies = {},
  -- init = function() end, -- functions are always executed during startup
  opts = {
    -- The interval between notifications in minutes
    minute_interval = 30,

    -- The render style for notifications
    -- Accepted values are "default", "minimal", "simple" or "compact"
    render_style = "simple",
    -- render_style = "compact",

    -- Loads time of last drink on startup
    -- Useful if you don't have long-running neovim instances
    -- or if you tend to have multiple instances running at a time
    persist_timer = true,
  },
}
