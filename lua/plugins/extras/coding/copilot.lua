local printf = require("plugins.util.printf").printf
local wk = require("which-key")
local opts = { prefix = "<leader>" }
local mappings = {
  C = {
    name = "+copilot chat",
  },
}

wk.register(mappings, opts)

return {
  -- NOTE: copilot_cmp is not working atm.
  -- also copilot suggestion cannot generated in first or empty line.
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    -- enabled = false,
    dependencies = {
      { "AndreM222/copilot-lualine" },
    },

    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = "<c-a>", -- accapt all completeion.
            accept_word = "<c-k>", -- TODO: wezterm c-w is not working. change to c-k.
            accept_line = "<c-l>",
            next = "<c-;>",
            prev = "<c-,>",
            dismiss = "<C-x>",
          },
        },

        filetypes = {
          yaml = false,
          markdown = false,
          help = false,
          gitcommit = false,
          gitrebase = false,
          hgcommit = false,
          svn = false,
          cvs = false,
          ["."] = false,
        },
        copilot_node_command = "node", -- Node.js version must be > 18.x
        server_opts_overrides = {},
      })
    end,
  },

  -- TODO: make this work.
  -- {
  --   "nvim-lualine/lualine.nvim",
  --   event = "VeryLazy",
  --   dependencies = { "AndreM222/copilot-lualine" },
  --   opts = function(_, opts)
  --     table.insert(opts.sections.lualine_x, 2, { "copilot" })
  --   end,
  -- },

  {
    "CopilotC-Nvim/CopilotChat.nvim",
    opts = {
      show_help = "yes", -- Show help text for CopilotChatInPlace, default: yes
      debug = false, -- Enable or disable debug mode, the log file will be in ~/.local/state/nvim/CopilotChat.nvim.log
      disable_extra_info = "no", -- Disable extra information (e.g: system prompt) in the response.
      language = "English", -- Copilot answer language settings when using default prompts. Default language is English.
      -- proxy = "socks5://127.0.0.1:3000", -- Proxies requests via https or socks.
      -- temperature = 0.1,
    },
    build = function()
      vim.notify("Please update the remote plugins by running ':UpdateRemotePlugins', then restart Neovim.")
    end,
    event = "VeryLazy",
    keys = {
      { "<leader>Cb", ":CopilotChatBuffer ", desc = printf("CopilotChat - Chat with current buffer") },
      { "<leader>Cc", ":CopilotChat ", desc = printf("CopilotChat - Chat") },
      { "<leader>Ce", "<cmd>CopilotChatExplain<cr>", desc = printf("CopilotChat - Explain code") },
      { "<leader>CT", "<cmd>CopilotChatTests<cr>", desc = printf("CopilotChat - Generate tests") },
      { "<leader>Ct", "<cmd>CopilotChatVsplitToggle<cr>", desc = printf("CopilotChat - Toggle Vsplit") },
      { "<leader>Cv", ":CopilotChatVisual ", mode = "x", desc = printf("CopilotChat - Open in vertical split") },
      { "<leader>Cx", ":CopilotChatInPlace<cr>", mode = "x", desc = printf("CopilotChat - Run in-place code") },
      { "<leader>Cf", "<cmd>CopilotChatFixDiagnostic<cr>" }, -- Get a fix for the diagnostic message under the cursor. desc = printf"CopilotChat - Fix diagnostic",
      { "<leader>Cr", "<cmd>CopilotChatReset<cr>" }, -- Reset chat history and clear buffer. desc = printf"CopilotChat - Reset chat history and clear buffer",
    },
  },
}
