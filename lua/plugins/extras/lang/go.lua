-- NOTE: this go plugin is much better than vim-go by fatih as it uses the modern lua and by default integrated with nvim-lspconfig
-- no hassle with duplicate gopls server in memory
-- https://github.com/ray-x/go.nvim?ref=morioh.com&utm_source=morioh.com

return {
  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",

      {
        -- NOTE: uses highlighter from this plugin instead of treesitter
        -- which doesnt convey alot of go common syntax highlighter like printf %v, & and * pointer in type and other.
        "charlespascoe/vim-go-syntax",
        config = function()
          vim.g.go_highlight_comma = 1 -- it uses the highlight color of func?
          vim.g.go_highlight_fields = 1
          vim.g.go_highlight_struct_fields = 1
          vim.g.go_highlight_variable_assignments = 1
          vim.g.go_highlight_semicolon = 1
          vim.g.go_highlight_struct_type_fields = 1

          vim.g.go_highlight_variable_declarations = 0 -- disable highlight in var name of 'kaobm', ex. kaobm := os.Getenv("REDIS_HOST")
          -- vim.g.go_highlight_dot = 0 -- this works
        end,
      },
    },

    config = function()
      require("go").setup()
      local notify = require("notify")

      -- NOTE: autocmd
      local autocmd = vim.api.nvim_create_autocmd
      local augroup = vim.api.nvim_create_augroup

      -- Run gofmt + goimport on save - go.nvim
      local format_sync_grp = augroup("GoImport", {})
      autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function()
          require("go.format").goimport()
          notify("Go file(s) saved.\nHave you run GoLint or GoTest?", "info", { title = "go.nvim" })
        end,
        group = format_sync_grp,
      })
      -- NOTE: end of autocmd

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
              s = { "<cmd>GoFillStruct<cr>", "Go Fill Struct" },
              f = { "<cmd>GoFillSwitch<cr>", "Go Fill Switch" },

              T = {
                name = "+go tags",
                a = {
                  "<cmd>GoModifyTag -add-tags json -transform camelcase -add-options json=<cr>",
                  "Go Add Tags No 'omitempty'",
                },
                A = {
                  "<cmd>GoModifyTag -add-tags json -transform camelcase<cr>",
                  "Go Add Tags",
                },
                r = { "<cmd>GoRmTag<cr>", "Go Remove Tags" },
              },

              r = { "<cmd>GoRename<cr>", "Go Rename" },

              t = {
                -- TODO: update some test to have argument. use func in keymaps?
                name = "+go test",
                a = { "<cmd>GoAddTest<cr>", "Go Add Test for Current Func" },
                A = { "<cmd>GoAddAllTest<cr>", "Go Add Test for all Func" },
                e = { "<cmd>GoAddExpTest<cr>", "Go Add Exported Func" },
                t = { "<cmd>GoTest<cr>", "Go Test All" },
                f = { "<cmd>GoTestFunc<cr>", "Go Test a Func" },
                F = { "<cmd>GoTestFile<cr>", "Go Test All Func in the File" },
                P = { "<cmd>GoTestPkg<cr>", "Go Test Package" },
                c = { "<cmd>GoCoverage<cr>", "Go Test -coverprofile" },
              },

              d = {
                function()
                  local docName = vim.fn.input("Specify Go Doc: ")
                  if docName == "" then
                    notify("Cannot find empty doc", "warn", { title = "go.nvim" })
                  else
                    local godoc = string.format(":GoDoc %s", docName)
                    vim.cmd(godoc)
                  end
                end,
                "Go Doc",
              },
              e = { "<cmd>GoIfErr<cr>", "Go Auto Generate 'if err'" },
              l = { "<cmd>GoLint<cr>", "Go Run 'golangci_lint'" },
              c = { "<cmd>GoCheat<cr>", "Go Cheatsheet" },
              -- c = { "<cmd>GoCmt<cr>", "Go Generate Func Comments" },
              m = { "<cmd>Gomvp<cr>", "Go Rename Module name" },
              -- map("n", "<leader>lgm", "<cmd>GoFixPlurals<cr>", { desc = "Go Fix Redundant Func Params" }) -- not working?
            },
          }

          wk.register(mappings, opts)
        end
      end)
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
        -- NOTE: it is better to install golangci_lint via binary from official web https://golangci-lint.run/usage/install/
        -- after installed running golint in the terminal and using ray-x/go.nvim work flawlessly.

        -- NOTE: need to installed golangci_lint_ls and golangci_lint to avoid lag when running golangci
        vim.list_extend(opts.ensure_installed, { "gopls" })
      end
    end,
  },

  -- NOTE: installing golangci from official web and disable other golangci install in mason will make this work
  -- however, it doesnt work in igaming repo at all.
  -- TODO: create custom golangci_lint for null-ls? to run like ray-x/go.nvim GoLint command?
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      table.insert(opts.sources, nls.builtins.diagnostics.golangci_lint)
    end,
  },

  -- install all go's parser to treesitter and disable 'go' parser
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        -- NOTE: still install 'go' but make it disabled in nvim-treesitter to not use the parser but use vim-go-syntax instead
        vim.list_extend(opts.ensure_installed, { "go", "gomod", "gosum", "gowork" })
      end

      if type(opts.highlight.disable) == "table" then
        -- NOTE: disable go TS to use vim-go-syntx highlight instead but still uses the ts plugins like ts-rainbow and context
        vim.list_extend(opts.highlight.disable, { "go" })
      else
        -- NOTE: in case the table is yet to be created in lazyvim plugin config so this else will create a new table
        opts.highlight.disable = { "go" }
      end
    end,
  },
}
