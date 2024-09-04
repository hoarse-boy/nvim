local printf = require("plugins.util.printf").printf

return {
  "rcarriga/nvim-notify",
  -- NOTE: requiring notify to any other file will result in notify or any lua plugin to use the default.
  keys = {
    {
      "<leader>uH",
      function()
        require("telescope").extensions.notify.notify()
      end,
      desc = printf("Open Notify History"),
    },
  },
}
