return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      -- {
      --   "leoluz/nvim-dap-go",
      --   config = function()
      --     require("dap-go").setup()
      --   end,
      -- },
      -- TODO: find out how to install and compile it https://github.com/Joakker/lua-json5
      -- FIX: fail to build. find out why
      -- https://github.com/folke/lazy.nvim/issues/368
      -- require('dap.ext.vscode').json_decode = require'json5'.parse
      -- {
      --   "Joakker/lua-json5",
      --   build = "./install.sh",
      -- },
    },
    opts = function()
      -- NOTE: enabling nvim to load .vscode/launch.json file for debuging
      -- add rt_lldb for debuging rust using plugin rust-tools
      require("dap.ext.vscode").load_launchjs(nil, { rt_lldb = { "rust" } })
    end,
  },
}
