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
        -- enabled = false, -- disabled plugin
        config = function()
          vim.g.go_highlight_comma = 1 -- it uses the highlight color of func?
          -- NOTE: with catpuccin it is better in vanilla setting. but need to be changed. the highlight is called 'Identifier'
          vim.g.go_highlight_fields = 1 -- Fields in expressions, e.g. bar in foo.bar = 123
          vim.g.go_highlight_struct_fields = 1 -- Field names in struct literals, e.g. Bar in f := Foo{ Bar: 123 }.
          vim.g.go_highlight_variable_assignments = 1
          -- vim.g.go_highlight_types = 0
          -- vim.g.go_highlight_type_parameters = 0
          vim.g.go_highlight_semicolon = 1
          vim.g.go_highlight_struct_type_fields = 1
          vim.g.go_highlight_struct_tags = 1 -- Struct tags, the backtick-delimited strings in structs, e.g. `json:bar` in struct { Bar int `json:"bar"` }.
          vim.g.go_highlight_function_parameters = 1 -- Parameter names, e.g. bar in func foo(bar int)
          vim.g.go_highlight_slice_brackets = 1 -- The brackets in slice types, e.g. []string.
          vim.g.go_highlight_variable_declarations = 1 -- disable highlight in var name of 'kaobm', ex. kaobm := os.Getenv("REDIS_HOST")
          -- vim.g.go_highlight_dot = 0 -- this works
        end,
      },
    },

    config = function()
      require("go").setup({
        lsp_inlay_hints = {
          enable = false, -- disable go.nvim inlay as it is currently buggy.
          -- hint style, set to 'eol' for end-of-line hints, 'inlay' for inline hints
          -- inlay only avalible for 0.10.x
          style = "inlay",
        },
      })

      -- NOTE: autocmd
      local autocmd = vim.api.nvim_create_autocmd
      local augroup = vim.api.nvim_create_augroup

      -- Run gofmt + goimport on save - go.nvim
      local format_sync_grp = augroup("GoImport", {})
      autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function()
          require("go.format").goimport()

          -- print notification
          notify("# Have you:\n- run GoTest?\n- run GoLint?\n- checked todo 'FIX:'?", "info", {
            title = "go.nvim",
            on_open = function(win)
              local buf = vim.api.nvim_win_get_buf(win)
              vim.api.nvim_buf_set_option(buf, "filetype", "markdown")
            end,
          })
        end,
        group = format_sync_grp,
      })
      -- NOTE: end of autocmd

      -- use this to make which key shows for gopls buffer only
      require("lazyvim.util").lsp.on_attach(function(client, buffer)
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
              T = {
                name = "+go tags",
              },
              t = {
                name = "+go test",
              },
              -- goplay.nvim
              p = {
                name = "+goplay.nvim",
              },
            },
          }

          wk.register(mappings, opts)
        end
      end)
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },

  -- TODO: copy all from lazy go language config but alter a bit
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {
          settings = {
            gopls = {
              gofumpt = false,
              codelenses = {
                gc_details = false,
                generate = true,
                regenerate_cgo = true,
                run_govulncheck = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
              },
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
              analyses = {
                fieldalignment = false,
                nilness = true,
                unusedparams = false,
                unusedwrite = false,
                useany = true,
              },
              usePlaceholders = true,
              completeUnimported = true,
              staticcheck = true,
              directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
              semanticTokens = true,
            },
          },

          keys = {
            -- { "<leader>la", "<cmd>GoCodeAction<cr>", desc = "Code Action" },

            { "<leader>ls", "<cmd>GoFillStruct<cr>", desc = "Fill Struct" },
            { "<leader>lf", "<cmd>GoFillSwitch<cr>", desc = "Fill Switch" },
            { "<leader>lr", vim.lsp.buf.rename, desc = "Rename" },
            -- { "<leader>lr", "<cmd>GoRename<cr>", desc = "Rename" }, -- NOTE: is buggy. use vim.lsp.buf.rename instead

            -- T = tags
            -- stylua: ignore
            { "<leader>lTa", "<cmd>GoModifyTag -add-tags json -transform camelcase -add-options json=<cr>", desc = "Add Tags No 'omitempty'", },
            -- stylua: ignore
            { "<leader>lTj", "<cmd>GoModifyTag -add-tags json -transform snakecase -add-options json=<cr>", desc = "Add Tags snakecase No 'omitempty'", },
            { "<leader>lTA", "<cmd>GoModifyTag -add-tags json -transform camelcase<cr>", desc = "Add Tags" },
            { "<leader>lTr", "<cmd>GoRename<cr>", desc = "Remove Tags" },

            -- t = test
            { "<leader>lta", "<cmd>GoAddTest<cr>", desc = "Add Test for Current Func" },
            { "<leader>ltA", "<cmd>GoAddAllTest<cr>", desc = "Add Test for all Func" },
            { "<leader>lte", "<cmd>GoAddExpTest<cr>", desc = "Add Exported Func" },
            { "<leader>ltT", "<cmd>GoTest<cr>", desc = "Test All" },
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

            -- goplay.nvim keymaps
            { "<leader>lpo", ":GPOpen<CR>", desc = "Open Goplay" },
            { "<leader>lpt", ":GPToggle<CR>", desc = "Toggle Goplay" },
            { "<leader>lpe", ":GPExec<CR>", desc = "Execute" },
            { "<leader>lpE", ":GPExecFile<CR>", desc = "Execute File" },
            { "<leader>lpc", ":GPClose<CR>", desc = "Close Goplay" },
            { "<leader>lpC", ":GPClear<CR>", desc = "Clear Goplay" },
          },
        },
      },

      setup = {
        gopls = function(_, _)
          -- gopls = function(_, opts)
          -- workaround for gopls not supporting semanticTokensProvider
          -- https://github.com/golang/go/issues/54531#issuecomment-1464982242
          require("lazyvim.util").lsp.on_attach(function(client, bufnr)
            if client.name == "gopls" then
              if not client.server_capabilities.semanticTokensProvider then
                local semantic = client.config.capabilities.textDocument.semanticTokens
                client.server_capabilities.semanticTokensProvider = {
                  full = true,
                  legend = {
                    tokenTypes = semantic.tokenTypes,
                    tokenModifiers = semantic.tokenModifiers,
                  },
                  range = true,
                }
              end
            end
            -- end workaround

            -- Enable inlay hints if the client supports it.
            -- with a logic to make it disable when going into invsert mode.
            if client.server_capabilities.inlayHintProvider then
              local inlay_hints_group = vim.api.nvim_create_augroup("InlayHints", { clear = false })

              vim.lsp.inlay_hint.enable(bufnr, true) -- enable this only in go buffer

              vim.api.nvim_create_autocmd("InsertEnter", {
                group = inlay_hints_group,
                buffer = bufnr,
                callback = function()
                  vim.lsp.inlay_hint.enable(bufnr, false)
                end,
              })
              vim.api.nvim_create_autocmd("InsertLeave", {
                group = inlay_hints_group,
                buffer = bufnr,
                callback = function()
                  vim.lsp.inlay_hint.enable(bufnr, true)
                end,
              })
            end
          end)
        end,
      },
    },
  },

  -- correctly setup mason lsp / dap extensions
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        -- NOTE: must install golangci_lint via binary from official web https://golangci-lint.run/usage/install/
        -- installing from mason will have different path and other issue like, running golangci_lint in terminal will cause pc to lag
        -- after installed running golint in the terminal and using ray-x/go.nvim work flawlessly.
        vim.list_extend(opts.ensure_installed, { "gopls" })
      end
    end,
  },

  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      {
        "mason.nvim",
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          vim.list_extend(opts.ensure_installed, { "gomodifytags", "impl", "goimports", "delve" })
        end,
      },
      {
        "leoluz/nvim-dap-go",
        config = true,
      },
    },
  },

  {
    "nvimtools/none-ls.nvim",
    optional = true,
    opts = function(_, opts)
      if type(opts.sources) == "table" then
        local nls = require("null-ls")
        vim.list_extend(opts.sources, {
          nls.builtins.code_actions.gomodifytags,
          nls.builtins.code_actions.impl,
          -- used ray-x go nvim above to create autcmd instead.
          -- nls.builtins.formatting.gofumpt,
          -- nls.builtins.formatting.gofmt,
          -- nls.builtins.formatting.goimports_reviser,
        })
      end
    end,
  },

  -- used ray-x go nvim above to create autcmd instead.
  -- -- FIX: test to ditch ray-x go.nvim
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        go = { "goimports", "gofmt" },
        -- go = { "goimports", "gofumpt" },
      },
    },
  },

  -- install all go's parser to treesitter and disable 'go' parser to use vim-go-syntax's highlighter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        -- NOTE: still install 'go' but make it disabled in nvim-treesitter to not use the parser but use vim-go-syntax instead
        vim.list_extend(opts.ensure_installed, { "go", "gomod", "gosum", "gowork" })
      end

      -- TODO: remove this, after nvim-treesitter can have %v and other fmt related string highlighter enabled.
      if type(opts.highlight.disable) == "table" then
        -- NOTE: disable go TS to use vim-go-syntx highlight instead but still uses the ts plugins like ts-rainbow and context
        vim.list_extend(opts.highlight.disable, { "go" })
      else
        -- NOTE: in case the table is yet to be created in lazyvim plugin config so this else will create a new table
        opts.highlight.disable = { "go" }
      end
    end,
  },

  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "nvim-neotest/neotest-go",
    },
    opts = {
      adapters = {
        ["neotest-go"] = {
          -- Here we can set options for neotest-go, e.g.
          -- args = { "-tags=integration" }
        },
      },
    },
  },

  {
    "jeniasaigak/goplay.nvim", -- https://github.com/jeniasaigak/goplay.nvim
    event = "VeryLazy",
    config = function()
      require("goplay").setup({
        template = require("goplay.templates").default, -- template which will be used as the default content for the playground
        mode = "current", -- current/split/[vsplit] specifies where the playground will be opened
        -- mode = "vsplit", -- current/split/[vsplit] specifies where the playground will be opened
        playgroundDirName = "goplayground", -- a name of the directory under GOPATH/src where the playground will be saved
        tempPlaygroundDirName = "goplayground_temp", -- a name of the directory under GOPATH/src where the temporary playground will be saved. This option is used when you need to execute a file
        output_mode = "raw", -- [formatted]/raw mode to display output
        -- output_mode = "formatted", -- [formatted]/raw mode to display output
      })
    end,
  },
}
