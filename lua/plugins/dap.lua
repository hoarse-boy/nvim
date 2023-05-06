local dapBuddy = { "Pocco81/dap-buddy.nvim", branch = "dev" } -- use branch dev to use the dap installation. as branch master has some breaking changes

return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "leoluz/nvim-dap-go",
      dapBuddy,
      "theHamsta/nvim-dap-virtual-text",
      "nvim-telescope/telescope-dap.nvim",
    },
    config = function()
      require("config.dap").setup()
    end,
    event = "VeryLazy", -- will lazyload dap with no notify error
    -- using cmd below has some drawbacks. there will a error notify about the plugins
    -- however, the plugin can still be used normally
    -- cmd = "require'dap'.continue()", -- make it start when clicking the command for starting a dap
  },

  -- update neodev to have library for nvim-dap-ui
  {
    "folke/neodev.nvim",
    event = "VeryLazy",
    opts = {
      library = { plugins = { "nvim-dap-ui" }, types = true },
    },
  },
}
