-- NOTE: this go plugin is much better than vim-go by fatih as it uses the modern lua and by default integrated with nvim-lspconfig
-- no hassle with duplicate gopls server in memory
-- https://github.com/ray-x/go.nvim?ref=morioh.com&utm_source=morioh.com

return {
  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",

      -- update TS opts
      {
        "nvim-treesitter/nvim-treesitter",
        opts = {
          highlight = {
            disable = { "go" }, -- NOTE: disable go TS to use vim-go-syntx highlight instead but still uses the ts plugins like  ts-rainbow and context
          },
        },
      },

      {
        -- NOTE: uses highlighter from this plugin instead of treesitter which doesnt convey alot of go common syntax highlighter like printf %v, & and * pointer in type and other
        --
        "charlespascoe/vim-go-syntax",
        config = function()
          vim.g.go_highlight_comma = 1 -- FIX: not working?
          vim.g.go_highlight_fields = 1
          vim.g.go_highlight_struct_fields = 1
          vim.g.go_highlight_variable_assignments = 1

          -- vim.g.go_highlight_dot = 0 -- this works
        end,
      },
    },

    config = function()
      require("go").setup()

      -- autocmd
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

      -- use this to make which key shows for gopls buffer only
      require("lazyvim.util").on_attach(function(client, buffer)
        if client.name == "gopls" then
          local wk = require("which-key")
          local opts = {
            mode = "n", -- NORMAL mode
            -- prefix: use "<leader>f" for example for mapping everything related to finding files
            -- the prefix is prepended to every mapping part of `mappings`
            prefix = "<leader>",
            -- NOTE: use buffer from lazyvim.util to only shows keymaps on the targetted buffer
            buffer = buffer, -- Global mappings. Specify a buffer number for buffer local mappings
            silent = true, -- use `silent` when creating keymaps
            noremap = true, -- use `noremap` when creating keymaps
            nowait = false, -- use `nowait` when creating keymaps
            expr = false, -- use `expr` when creating keymaps
          }

          local mappings = {
            l = {
              name = "+lsp (go.nvim)",
              -- TODO: add more parent key like. sf to fill struct?
              s = { "<cmd>GoFillStruct<cr>", "Go Fill Struct" },
              f = { "<cmd>GoFillSwitch<cr>", "Go Fill Switch" },
              t = { "<cmd>GoAddTag<cr>", "Go Add Tags" },
              R = { "<cmd>GoRmTag<cr>", "Go Remove Tags" },
              r = { "<cmd>GoRename<cr>", "Go Rename" },

              T = { "<cmd>GoTestFun<cr>", "Go Test a Function" },
              A = { "<cmd>GoTestPkg<cr>", "Go Test Package" },
              e = { "<cmd>GoIfErr<cr>", "Go Auto Generate 'if err'" },
              c = { "<cmd>GoCmt<cr>", "Go Generate Func Comments" },
              m = { "<cmd>Gomvp<cr>", "Go Rename Module name" },
              -- map("n", "<leader>lgm", "<cmd>GoFixPlurals<cr>", { desc = "Go Fix Redundant Func Params" }) -- not working?
            },
          }

          wk.register(mappings, opts)
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
  },

  -- correctly setup mason lsp / dap extensions
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "gopls" })
      end
    end,
  },

  -- install all go's parser to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "gomod", "gosum", "gowork" })
        -- vim.list_extend(opts.ensure_installed, { "go", "gomod", "gosum", "gowork" })
      end
    end,
  },
}
