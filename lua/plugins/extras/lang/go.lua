-- NOTE: this go plugin is much better than vim-go by fatih as it uses the modern lua and by default integrated with nvim-lspconfig
-- no hassle with duplicate gopls server in memory
-- https://github.com/ray-x/go.nvim?ref=morioh.com&utm_source=morioh.com

local notify = require("notify")

return {
  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      {
        -- NOTE: uses highlighter from this plugin instead of treesitter
        -- which doesnt convey alot of go common syntax highlighter like printf %v, & and * pointer in type and other.
        "charlespascoe/vim-go-syntax",
        config = function()
          vim.g.go_highlight_comma = 1 -- it uses the highlight color of func?
          vim.g.go_highlight_fields = 0 -- Fields in expressions, e.g. bar in foo.bar = 123
          vim.g.go_highlight_struct_fields = 0 -- Field names in struct literals, e.g. Bar in f := Foo{ Bar: 123 }.
          vim.g.go_highlight_variable_assignments = 1
          -- vim.g.go_highlight_types = 0
          -- vim.g.go_highlight_type_parameters = 0
          vim.g.go_highlight_semicolon = 1
          vim.g.go_highlight_struct_type_fields = 1
          vim.g.go_highlight_function_parameters = 0 -- Parameter names, e.g. bar in func foo(bar int)
          -- vim.g.go_highlight_slice_brackets = 0

          vim.g.go_highlight_variable_declarations = 0 -- disable highlight in var name of 'kaobm', ex. kaobm := os.Getenv("REDIS_HOST")
          -- vim.g.go_highlight_dot = 0 -- this works
        end,
      },
    },

    config = function()
      require("go").setup()

      -- NOTE: autocmd
      local autocmd = vim.api.nvim_create_autocmd
      local augroup = vim.api.nvim_create_augroup

      -- Run gofmt + goimport on save - go.nvim
      local format_sync_grp = augroup("GoImport", {})
      autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function()
          require("go.format").goimport()
          notify("run GoTest?", "info", { title = "go.nvim" })
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

          -- TODO: change this just like rust config in default lazyvim.
          local mappings = {
            l = {
              name = "+lsp (go.nvim)",
              T = {
                name = "+go tags",
              },
              t = {
                name = "+go test",
              },
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

  -- TODO: move the keymaps above to this keys table
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Ensure mason installs the server
        gopls = {
          keys = {
            -- TODO: put the keymaps like above
            { "<leader>ls", "<cmd>GoFillStruct<cr>", desc = "Fill Struct" },
            { "<leader>lf", "<cmd>GoFillSwitch<cr>", desc = "Fill Switch" },
            { "<leader>lr", "<cmd>GoRename<cr>", desc = "Rename" },

            -- stylua: ignore
            -- T = tags
            { "<leader>lTa", "<cmd>GoModifyTag -add-tags json -transform camelcase -add-options json=<cr>", desc = "Add Tags No 'omitempty'", },
            { "<leader>lTA", "<cmd>GoModifyTag -add-tags json -transform camelcase<cr>", desc = "Add Tags" },
            { "<leader>lTr", "<cmd>GoRename<cr>", desc = "Remove Tags" },

            -- t = test
            { "<leader>lta", "<cmd>GoAddTest<cr>", desc = "Add Test for Current Func" },
            { "<leader>ltA", "<cmd>GoAddAllTest<cr>", desc = "Add Test for all Func" },
            { "<leader>lte", "<cmd>GoAddExpTest<cr>", desc = "Add Exported Func" },
            { "<leader>ltt", "<cmd>GoTest<cr>", desc = "Test All" },
            { "<leader>ltt", "<cmd>GoTestFunc<cr>", desc = "Test a Func" },
            { "<leader>ltF", "<cmd>GoTestFile<cr>", desc = "Test All Func in the File" },
            { "<leader>ltP", "<cmd>GoTestPkg<cr>", desc = "Test Package" },
            { "<leader>ltc", "<cmd>GoCoverage<cr>", desc = "Test -coverprofile" },

            {
              "<leader>ld",
              function()
                local docName = vim.fn.input("Specify Go Doc: ")
                if docName == "" then
                  notify("Cannot find empty doc", "warn", { title = "go.nvim" })
                else
                  local godoc = string.format(":GoDoc %s", docName)
                  vim.cmd(godoc)
                end
              end,
              desc = "Go Doc",
            },

            { "<leader>le", "<cmd>GoIfErr<cr>", desc = "Auto Generate 'if err'" },
            { "<leader>ll", "<cmd>GoLint<cr>", desc = "Run 'golangci_lint'" },
            { "<leader>lc", "<cmd>GoCheat<cr>", desc = "Cheatsheet" },
            { "<leader>lm", "<cmd>Gomvp<cr>", desc = "Rename Module name" },
            -- c = { "<cmd>GoCmt<cr>", "Go Generate Func Comments" },
            -- map("n", "<leader>lgm", "<cmd>GoFixPlurals<cr>", { desc = "Go Fix Redundant Func Params" }) -- not working?
          },
        },
      },
    },
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
