return {
  "rcarriga/nvim-notify",
  -- TODO: make the nvim-notify to have different animation.
  opts = {
    stages = "fade",
    -- timeout = 3000,
    -- max_height = function()
    --   return math.floor(vim.o.lines * 0.75)
    -- end,
    -- max_width = function()
    --   return math.floor(vim.o.columns * 0.75)
    -- end,
  },
  -- opts = function(_, opts)
  --   opts.stages = "fade"
  --   --   {
  --   --   background_colour = "NotifyBackground",
  --   --   fps = 30,
  --   --   icons = {
  --   --     DEBUG = "",
  --   --     ERROR = "",
  --   --     INFO = "",
  --   --     TRACE = "✎",
  --   --     WARN = ""
  --   --   },
  --   --   level = 2,
  --   --   minimum_width = 50,
  --   --   render = "default",
  --   --   stages = "fade_in_slide_out",
  --   --   timeout = 5000,
  --   --   top_down = true
  --   -- }
  -- end,

  keys = {
    {
      "<leader>uh",
      function()
        require("telescope").extensions.notify.notify()
      end,
      desc = "Open Notify History",
    },
  },
}
