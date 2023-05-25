-- NOTE: this go plugin is much better than vim-go by fatih as it uses the modern lua and by default integrated with nvim-lspconfig
-- no hassle with duplicate gopls server in memory
-- https://github.com/ray-x/go.nvim?ref=morioh.com&utm_source=morioh.com
return {
  "ray-x/go.nvim",
  dependencies = { -- optional packages
    "ray-x/guihua.lua",
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
  },

  config = function()
    require("go").setup()

    local autocmd = vim.api.nvim_create_autocmd
    local augroup = vim.api.nvim_create_augroup

    -- Run gofmt + goimport on save - go.nvim
    local format_sync_grp = augroup("GoImport", {})
    autocmd("BufWritePre", {
      pattern = "*.go",
      callback = function()
        require("go.format").goimport()
      end,
      group = format_sync_grp,
    })

    -- use this to make keymap shows for gopls buffer only
    require("lazyvim.util").on_attach(function(client, buffer)
      if client.name == "gopls" then
        local wk = require("which-key")
        local opts = {
          mode = "n", -- NORMAL mode
          -- prefix: use "<leader>f" for example for mapping everything related to finding files
          -- the prefix is prepended to every mapping part of `mappings`
          prefix = "<leader>",
          -- prefix = "<leader>c",
          buffer = buffer, -- Global mappings. Specify a buffer number for buffer local mappings
          silent = true, -- use `silent` when creating keymaps
          noremap = true, -- use `noremap` when creating keymaps
          nowait = false, -- use `nowait` when creating keymaps
          expr = false, -- use `expr` when creating keymaps
        }

        local mappings = {
          l = {
            name = "+lsp (go.nvim)",
            z = { "<cmd>Telescope find_files<cr>", "Find File" }, -- create a binding with label
          },
        }

        wk.register(mappings, opts)

        -- FIX: create which key
        -- fix
              -- stylua: ignore
              vim.keymap.set("n", "<leader>cz", "<cmd>TypescriptOrganizeImports<CR>", { buffer = buffer, desc = "Organize Imports" })
              -- stylua: ignore
              vim.keymap.set("n", "<leader>cR", "<cmd>TypescriptRenameFile<CR>", { desc = "Rename File", buffer = buffer })
      end
    end)

    -- require("go").setup({
    --   goimport = "gopls", -- if set to 'gopls' will use golsp format
    --   gofmt = "gopls", -- if set to gopls will use golsp format
    --   max_line_len = 120,
    --   tag_transform = false,
    --   test_dir = "",
    --   comment_placeholder = "   ",
    --   lsp_cfg = false, -- false: use your own lspconfig
    --   lsp_gofumpt = true, -- true: set default gofmt in gopls format to gofumpt
    --   lsp_on_attach = true, -- use on_attach from go.nvim
    --   dap_debug = true,
    -- })
  end,
  event = { "CmdlineEnter" },
  ft = { "go", "gomod" },
  -- build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
}
