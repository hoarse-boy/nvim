local M = {}

local function configure()
  local dap_install = require("dap-install")
  dap_install.setup({
    installation_path = vim.fn.stdpath("data") .. "/dapinstall/",
  })

  local dap_breakpoint = {
    error = {
      text = "🔥", -- https://unicode-table.com/en/1F525/
      texthl = "LspDiagnosticsSignError",
      linehl = "",
      numhl = "",
    },
    rejected = {
      text = "",
      texthl = "LspDiagnosticsSignHint",
      linehl = "",
      numhl = "",
    },
    stopped = {
      text = "⭐️",
      texthl = "LspDiagnosticsSignInformation",
      linehl = "DiagnosticUnderlineInfo",
      numhl = "LspDiagnosticsSignInformation",
    },
  }

  vim.fn.sign_define("DapBreakpoint", dap_breakpoint.error)
  vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)
  vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.rejected)
end

local function configure_exts()
  require("nvim-dap-virtual-text").setup({
    commented = true,
  })

  local dap, dapui = require("dap"), require("dapui")
  dapui.setup({}) -- use default
  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
    -- dap.repl.toggle() -- NOTE: now this is buggy, the symbol not working unless open the main UI and open this ui again to work
    -- do not use full UI as it is buggy as hell.
    -- use dap.repl.toggle() to toggle on and of when starting and exiting dap
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
    -- dap.repl.toggle()
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
    -- dap.repl.toggle()
  end
end

local function configure_debuggers()
  require("config.dap.lua").setup()
  -- require("config.dap.python").setup()
  -- require("config.dap.rust").setup()
  require("config.dap.go").setup()

  -- NOTE: uses load_launchjs instead of json5 below for now
  -- use the exact json from vscode but note that the json is strict by defult on luvarnim as it uses json_decode not json5 (can have comments next to values and trailing comma)
  -- create in root folder = .vscode/launch.json
  require("dap.ext.vscode").load_launchjs(nil, {})
  -- require('dap.ext.vscode').json_decode() = require'json5'.parse -- if the installation of json5 is a success, use this intead
end

function M.setup()
  configure() -- Configuration
  configure_exts() -- Extensions
  configure_debuggers() -- Debugger
  --
end

configure_debuggers()

return M
