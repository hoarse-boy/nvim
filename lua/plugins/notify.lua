return {
  "rcarriga/nvim-notify",
  -- NOTE: requiring notify to any other file will result in notify or any lua plugin to use the default.
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
