local lua = {}

function lua.setup()
  local dap = require("dap")
  dap.configurations.lua = {
    {
      type = "nlua",
      request = "attach",
      name = "Attach to running Neovim instance",
      host = function()
        local value = vim.fn.input("Host [127.0.0.1]: ")
        if value ~= "" then
          return value
        end
        return "127.0.0.1"
      end,
      port = function()
        local val = tonumber(vim.fn.input("Port: ", "54321"))
        assert(val, "Please provide a port number")
        return val
      end,
    },
  }

  dap.adapters.nlua = function(callback, config)
    callback({ type = "server", host = config.host, port = config.port })
  end
end

return {
  {
    "mfussenegger/nvim-dap",

    -- start of dependencies
    dependencies = {
      -- fancy UI for the debugger
      {
        "rcarriga/nvim-dap-ui",

      -- stylua: ignore
      keys = {
        { "<leader>du", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
        -- { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
      },

        opts = {},
        config = function(_, opts)
          local dap = require("dap")
          local dapui = require("dapui")
          dapui.setup(opts)
          dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open({})
            -- dap.repl.toggle() -- NOTE: now this is buggy, the symbol not working unless open the main UI and open this ui again to work
            -- use dap.repl.toggle() to toggle on and of when starting and exiting dap
          end
          dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close({})
          end
          dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close({})
          end
        end,
      },

      -- -- mason.nvim integration
      -- {
      --   "jay-babu/mason-nvim-dap.nvim",
      --   dependencies = "mason.nvim",
      --   cmd = { "DapInstall", "DapUninstall" },
      --   opts = {
      --     -- Makes a best effort to setup the various debuggers with
      --     -- reasonable debug configurations
      --     automatic_setup = true,

      --     -- You can provide additional configuration to the handlers,
      --     -- see mason-nvim-dap README for more information
      --     handlers = {},

      --     -- You'll need to check that you have the required things installed
      --     -- online, please don't ask me how to install them :)
      --     ensure_installed = {
      --       -- Update this to ensure that you have the debuggers for the langs you want
      --     },
      --   },
      -- },

      -- NOTE: add other plugin for other dap here
      -- add nvim-dap-go

      {
        "leoluz/nvim-dap-go",
        config = function()
          require("dap-go").setup()
        end,
      },

      -- NOTE: end of add other

      -- uses dev branch of dap buddy? change to use mason?
      -- https://github.com/Pocco81/dap-buddy.nvim/tree/dev
      { "Pocco81/dap-buddy.nvim", branch = "dev" },

      -- virtual text for the debugger
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {},
      },

      -- telescope-dap
      -- {
      --   "nvim-telescope/telescope-dap.nvim",
      --   opts = {},
      -- },

      -- update neodev to have library for nvim-dap-ui
      {
        "folke/neodev.nvim",
        event = "VeryLazy",
        opts = {
          library = { plugins = { "nvim-dap-ui" }, types = true },
        },
      },
    },
    -- end of dependencies

  -- start of keys
  -- stylua: ignore
  keys = {
    { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
    { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
    { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
    { "<leader>dg", function() require("dap").goto_() end, desc = "Go to line (no execute)" },
    { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
    { "<leader>dj", function() require("dap").down() end, desc = "Down" },
    { "<leader>dk", function() require("dap").up() end, desc = "Up" },
    { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
    { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
    { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
    { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
    { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
    { "<leader>ds", function() require("dap").session() end, desc = "Session" },
    { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
    -- { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" }, -- NOTE: what is this thing?

      -- open float_element of scopes
    { "<leader>dS", function() require("dapui").float_element("scopes", { width = 90, height = 100, enter = true, position = "center" }) end, desc = "Toggle Floating Scopes" },
     -- open other float_element
    { "<leader>dO", function() require("dapui").float_element(nil, { width = 90, height = 100, enter = true, position = "center" }) end, desc = "Toggle Other Floating Element" },
  },
    -- end of keys

    config = function()
      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

      -- PERF: enabling nvim to load .vscode/launch.json file for debuging
      -- added rt_lldb for debuging rust using plugin rust-tools
      require("dap.ext.vscode").load_launchjs(nil, { rt_lldb = { "rust" } })
      lua.setup()

      local Config = require("lazyvim.config") -- get the cool icons from default lazyvim repo
      for name, sign in pairs(Config.icons.dap) do
        sign = type(sign) == "table" and sign or { sign }
        vim.fn.sign_define(
          "Dap" .. name,
          { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
        )
      end
    end,

    event = "VeryLazy", -- will lazyload dap with no notify error
    -- using cmd below has some drawbacks. there will a error notify about the plSlugins
    -- however, the plugin can still be used normally
    -- cmd = "require'dap'.continue()", -- make it start when clicking the command for starting a dap
  },
}
