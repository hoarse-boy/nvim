return {
  {
    "stefanlogue/hydrate.nvim",
    event = "VeryLazy",
    -- This installs the latest stable release.
    -- Set to false or omit to install the latest development version
    version = "*",
    config = function()
      require("hydrate").setup({
        -- The interval between notifications in minutes
        minute_interval = 120,

        -- The render style for notifications
        -- Accepted values are "default", "minimal", "simple" or "compact"
        render_style = "compact",

        -- Loads time of last drink on startup
        -- Useful if you don't have long-running neovim instances
        -- or if you tend to have multiple instances running at a time
        persist_timer = true,

        -- Sets the reminder message after "minute_interval" minutes have
        -- passed to the the specified message
        msg_hydrate_now = " 💧 Time for a drink ",

        -- Sets the message after acknowledging the reminder to the
        -- specified message
        msg_hydrated = " 💧 You've had a drink, timer reset 💧",
      })
    end,
  },
  {
    "folke/which-key.nvim",
    opts = function(_, _)
      local printf = require("plugins.util.printf").printf
      local wk = require("which-key")
      local mapping = {
        { "<leader>Oh", "<cmd>HydrateNow<cr>", icon = "󰆫", desc = printf("Reset Hydrate Timer"), mode = "n" },
        { "<leader>Ow", "<cmd>HydrateWhen<cr>", icon = "󰆫", desc = printf("Show Remaining Hydrate Timer"), mode = "n" },
      }
      wk.add(mapping)
    end,
  },
}
