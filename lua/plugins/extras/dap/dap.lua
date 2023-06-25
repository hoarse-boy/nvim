return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "leoluz/nvim-dap-go",
        config = function()
          require("dap-go").setup()
        end,
      },
    },
    opts = function()
      -- PERF: enabling nvim to load .vscode/launch.json file for debuging
      -- added rt_lldb for debuging rust using plugin rust-tools
      require("dap.ext.vscode").load_launchjs(nil, { rt_lldb = { "rust" } })
    end,
  },
}
