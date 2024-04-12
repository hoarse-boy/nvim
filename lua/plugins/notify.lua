return {
  "rcarriga/nvim-notify",
  -- PERF: disabled animation as it is very costly.

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
