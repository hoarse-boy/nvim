return {
  -- FIX: using this, the build is successfull. but the json5 is still not found.
  -- https://github.com/neovim/neovim/issues/21749
  -- https://github.com/jamylak/nvim-github-codesearch/commit/e82c1b6452c2b890610c586562b233a66c296c00
  -- {
  --   "Joakker/lua-json5",
  --   lazy = false,
  --   build = "./install.sh",
  --   config = function()
  --     require("json5")
  --   end,
  -- },

  {
    "mfussenegger/nvim-dap",
    dependencies = {
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
      -- NOTE: open dap ui again in case the nvim dap existed / terminated to check if there is error log.
      -- however, developer must log if an error occured to make it easy to fix the issue to start debugging.

      vim.api.nvim_set_keymap("n", "<leader>dr", ":lua require('dapui').open({reset = true})<CR>", { noremap = true, silent = true, desc= "Reset DAP UI Windows" })
      vim.api.nvim_set_keymap("n", "<leader>dR", ":lua require('dap').repl.toggle()<CR>", { noremap = true, silent = true, desc= "Toggle REPL" })
      vim.api.nvim_set_keymap("n", "<leader>du", ":lua require('dapui').toggle({})<CR>", { noremap = true, silent = true, desc= "Toggle DAP UI" })
    end,
  },
}
