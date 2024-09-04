-- NOTE: a carbon copy from lazyvim with some modification to fix golang double debugger option.

---@param config {args?:string[]|fun():string[]?}
local function get_args(config)
  local args = type(config.args) == "function" and (config.args() or {}) or config.args or {}
  config = vim.deepcopy(config)
  ---@cast args string[]
  config.args = function()
    local new_args = vim.fn.input("Run with args: ", table.concat(args, " ")) --[[@as string]]
    return vim.split(vim.fn.expand(new_args) --[[@as string]], " ")
  end
  return config
end

return {
  {
    "mfussenegger/nvim-dap",
    recommended = true,
    desc = "Debugging support. Requires language specific adapters to be configured. (see lang extras)",

    dependencies = {
      "rcarriga/nvim-dap-ui",
      -- virtual text for the debugger
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {},
      },
      {
        "Joakker/lua-json5",
        event = "VeryLazy",
        build = "./install.sh", -- NOTE: make sure it to installed the latest version of rust, create, and cargo. last time it was failed when building it.
        config = function()
          require("json5")

          -- make only launch.json in .vscode dir to be jsonc.
          -- TODO: this is sometime not working if the previous open buffer is also a json and then open launch.json, it will show error again. find a way to fix it.
          vim.cmd([[
            au BufRead,BufNewFile */.vscode/launch.json set filetype=jsonc
          ]])
        end,
      },
    },

    -- stylua: ignore
    keys = {
      { "<leader>d",  "",                                                                                   desc = "+debug",                 mode = { "n", "v" } },
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
      { "<leader>db", function() require("dap").toggle_breakpoint() end,                                    desc = "Toggle Breakpoint" },
      { "<leader>dc", function() require("dap").continue() end,                                             desc = "Continue" },
      { "<leader>da", function() require("dap").continue({ before = get_args }) end,                        desc = "Run with Args" },
      { "<leader>dC", function() require("dap").run_to_cursor() end,                                        desc = "Run to Cursor" },
      { "<leader>dg", function() require("dap").goto_() end,                                                desc = "Go to Line (No Execute)" },
      { "<leader>di", function() require("dap").step_into() end,                                            desc = "Step Into" },
      { "<leader>dj", function() require("dap").down() end,                                                 desc = "Down" },
      { "<leader>dk", function() require("dap").up() end,                                                   desc = "Up" },
      { "<leader>dl", function() require("dap").run_last() end,                                             desc = "Run Last" },
      { "<leader>do", function() require("dap").step_out() end,                                             desc = "Step Out" },
      { "<leader>dO", function() require("dap").step_over() end,                                            desc = "Step Over" },
      { "<leader>dp", function() require("dap").pause() end,                                                desc = "Pause" },
      { "<leader>dr", function() require("dap").repl.toggle() end,                                          desc = "Toggle REPL" },
      { "<leader>ds", function() require("dap").session() end,                                              desc = "Session" },
      { "<leader>dt", function() require("dap").terminate() end,                                            desc = "Terminate" },
      { "<leader>dw", function() require("dap.ui.widgets").hover() end,                                     desc = "Widgets" },
    },

    config = function()
      -- load mason-nvim-dap here, after all adapters have been setup
      if LazyVim.has("mason-nvim-dap.nvim") then
        require("mason-nvim-dap").setup(LazyVim.opts("mason-nvim-dap.nvim"))
      end

      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

      for name, sign in pairs(LazyVim.config.icons.dap) do
        sign = type(sign) == "table" and sign or { sign }
        vim.fn.sign_define("Dap" .. name, {
          text = sign[1],
          texthl = sign[2] or "DiagnosticInfo",
          linehl = sign[3],
          numhl = sign[3],
        })
      end

      require("dap.ext.vscode").json_decode = require("json5").parse -- makes the json to have comments.

      local printf = require("plugins.util.printf").printf
      vim.api.nvim_set_keymap("n", "<leader>dr", ":lua require('dapui').open({reset = true})<CR>", { noremap = true, silent = true, desc = printf("Reset DAP UI Windows") })
      vim.api.nvim_set_keymap("n", "<leader>dR", ":lua require('dap').repl.toggle()<CR>", { noremap = true, silent = true, desc = printf("Toggle REPL") })
      vim.api.nvim_set_keymap("n", "<leader>du", ":lua require('dapui').toggle({})<CR>", { noremap = true, silent = true, desc = printf("Toggle DAP UI") })
      vim.api.nvim_set_keymap("n", "<F5>", ":lua require('dap').continue()<CR>", { noremap = true, silent = true, desc = printf("Continue") })
      vim.api.nvim_set_keymap("n", "<F7>", ":lua require('dap').toggle_breakpoint()<CR>", { noremap = true, silent = true, desc = printf("Toggle Breakpoint") })
      vim.api.nvim_set_keymap("n", "<F8>", ":lua require('dap').step_over()<CR>", { noremap = true, silent = true, desc = printf("Step Over") })
      vim.api.nvim_set_keymap("n", "<F9>", ":lua require('dap').step_into()<CR>", { noremap = true, silent = true, desc = printf("Step Into") })
      vim.api.nvim_set_keymap("n", "<F10>", ":lua require('dap').step_out()<CR>", { noremap = true, silent = true, desc = printf("Step Out") })
      vim.api.nvim_set_keymap("n", "<F12>", ":lua require('dapui').open({reset = true})<CR>", { noremap = true, silent = true, desc = printf("Reset DAP UI Windows") }) -- macos uses F11.

      -- NOTE: don't remove this comment.
      -- below is the code from lazyvim that makes vscode debugger to have double debugger option.
      -- and the option is not working because the env is not loaded. the second option works fine.
      -- setup dap config by VsCode launch.json file
      -- local vscode = require("dap.ext.vscode")
      -- local json = require("plenary.json")
      -- vscode.json_decode = function(str)
      --   return vim.json.decode(json.json_strip_comments(str))
      -- end
      -- Extends dap.configurations with entries read from .vscode/launch.json
      -- if vim.fn.filereadable(".vscode/launch.json") then
      -- vscode.load_launchjs()
      -- end
    end,
  },

  -- fancy UI for the debugger
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "nvim-neotest/nvim-nio" },
    -- stylua: ignore
    keys = {
      { "<leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI" },
      { "<leader>de", function() require("dapui").eval() end,     desc = "Eval",  mode = { "n", "v" } },
    },
    opts = {},
    config = function(_, opts)
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup(opts)
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open({})
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close({})
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close({})
      end
    end,
  },

  -- mason.nvim integration
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = "mason.nvim",
    cmd = { "DapInstall", "DapUninstall" },
    opts = {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
      },
    },
    -- mason-nvim-dap is loaded when nvim-dap loads
    config = function() end,
  },
}
