-- to change the keymaps of lspconfig use init (https://www.lazyvim.org/plugins/lsp#%EF%B8%8F-customizing-lsp-keymaps)
-- NOTE: only for lspconfig, will define the keymaps here, else will be in lua.config.keymaps folder
return {
  {
    -- LSP keymaps
    "neovim/nvim-lspconfig",
    -- event = { "BufReadPre", "BufNewFile" }, -- default
    init = function()
      local printf = require("plugins.util.printf").printf

      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- -- change a keymap
      -- keys[#keys + 1] = { "K", "<cmd>echo 'hello'<cr>" }
      -- -- disable a keymap
      -- keys[#keys + 1] = { "K", false }
      -- keys[#keys + 1] = { "<leader>c", false } -- NOTE: the whole "c" for lspconfig keymaps. will use "l" below as the new keymaps
      -- keys[#keys + 1] = { "<leader>cl", false }
      -- keys[#keys + 1] = { "<leader>ca", false, mode = { "n", "v" }, has = "codeAction" }
      -- keys[#keys + 1] = { "<leader>cA", false, mode = { "n", "v" }, has = "codeAction" }
      -- keys[#keys + 1] = { "<leader>cd", false }
      -- keys[#keys + 1] = { "<leader>cf", false }
      -- keys[#keys + 1] = { "<leader>cm", false }
      -- keys[#keys + 1] = { "<leader>cr", false }

      -- -- add a keymap
      -- keys[#keys + 1] = { "<leader>li", "<cmd>LspInfo<cr>", desc = printf"Lsp Info" }
      -- keys[#keys + 1] = { "<leader>lI", "<cmd>Mason<cr>", desc = printf"Mason Info" }
      -- keys[#keys + 1] = { "<leader>cR", "<cmd>LspRestart<CR>", desc = printf("Restart Lsp") }
      -- keys[#keys + 1] = { "<leader>cs", "<cmd>LspStart<CR>", desc = printf("Start Lsp") }

      -- NOTE: not working
      -- local format = require("lazyvim.plugins.lsp.format").format
      -- keys[#keys + 1] = { "<leader>lf", format, desc = printf"Format Document", has = "documentFormatting" }
      -- keys[#keys + 1] = { "<leader>lf", format, desc = printf"Format Range", mode = "v", has = "documentRangeFormatting" }

      -- TODO: use which-key below and remove these.
      -- swap the <leader>cd to gl line diagnostic
      keys[#keys + 1] = { "gl", vim.diagnostic.open_float, desc = printf("Line Diagnostics") }

      -- diagnostic
      local bufer_diagnostic = "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>"
      keys[#keys + 1] = { "<leader>cd", bufer_diagnostic, desc = printf("Buffer Diagnostics") }

      local workspace_diagnostic = "<cmd>Telescope diagnostics<cr>"
      keys[#keys + 1] = { "<leader>cD", workspace_diagnostic, desc = printf("Workspace Diagnostics") }

      --   keys[#keys + 1] =
      --     { "<leader>ca", vim.lsp.buf.code_action, desc = printf"Code Action", mode = { "n", "v" }, has = "codeAction" }

      --   if require("lazyvim.util").has("inc-rename.nvim") then
      --     keys[#keys + 1] = {
      --       "<leader>lr",
      --       function()
      --         require("inc_rename")
      --         return ":IncRename " .. vim.fn.expand("<cword>")
      --       end,
      --       expr = true,
      --       desc = printf"Rename",
      --       has = "rename",
      --     }
      --   else
      --     keys[#keys + 1] = { "<leader>lr", vim.lsp.buf.rename, desc = printf"Rename", has = "rename" }
      --   end
    end,
    opts = function(_, opts)
      -- globally enable inlay hint
      -- vim.api.nvim_create_autocmd("LspAttach", {
      --   group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      --   callback = function(args)
      --     local client = vim.lsp.get_client_by_id(args.data.client_id)
      --     if client.server_capabilities.inlayHintProvider then
      --       -- vim.lsp.inlay_hint.enable(bufnr, true)
      --       vim.lsp.inlay_hint.enable(args.buf, true)
      --     end
      --     -- whatever other lsp config you want
      --   end,
      -- })

      -- opts.inlay_hints = { enabled = false }

      vim.diagnostic.config({
        float = { border = "rounded" },
      })

      -- require("lspconfig").sqlls.setup({})
      --

      -- require("lspconfig").sqls.setup({}) -- FIX: if works move to different file and add mason install sqls
    end,
  },

  {
    "folke/which-key.nvim",
    opts = function(_, _)
      local printf = require("plugins.util.printf").printf
      local wk = require("which-key")
      local mapping = {
        { "<leader>cs", "<cmd>LspStart<CR>", desc = printf("Start Lsp"), mode = "n", icon = "" },
        { "<leader>cR", "<cmd>LspRestart<CR>", desc = printf("Restart Lsp"), mode = "n", icon = "󰜉" },
      }
      wk.add(mapping)
    end,
  },
}
