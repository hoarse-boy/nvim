-- NOTE: this go plugin is much better than vim-go by fatih as it uses the modern lua and by default integrated with nvim-lspconfig
-- no hassle with duplicate gopls server in memory
-- https://github.com/ray-x/go.nvim?ref=morioh.com&utm_source=morioh.com

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local go_keymaps = augroup("go_keymaps", {})

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
          vim.g.go_highlight_comma = 1         -- it uses the highlight color of func?
          -- NOTE: with catpuccin it is better in vanilla setting. but need to be changed. the highlight is called 'Identifier'
          vim.g.go_highlight_fields = 1        -- Fields in expressions, e.g. bar in foo.bar = 123
          vim.g.go_highlight_struct_fields = 1 -- Field names in struct literals, e.g. Bar in f := Foo{ Bar: 123 }.
          vim.g.go_highlight_variable_assignments = 1
          -- vim.g.go_highlight_types = 0
          -- vim.g.go_highlight_type_parameters = 0
          vim.g.go_highlight_semicolon = 1
          vim.g.go_highlight_struct_type_fields = 1
          vim.g.go_highlight_struct_tags = 1           -- Struct tags, the backtick-delimited strings in structs, e.g. `json:bar` in struct { Bar int `json:"bar"` }.
          vim.g.go_highlight_function_parameters = 1   -- Parameter names, e.g. bar in func foo(bar int)
          vim.g.go_highlight_slice_brackets = 1        -- The brackets in slice types, e.g. []string.
          vim.g.go_highlight_variable_declarations = 1 -- disable highlight in var name of 'kaobm', ex. kaobm := os.Getenv("REDIS_HOST")
          -- vim.g.go_highlight_dot = 0 -- this works
        end,
      },
    },

    config = function()
      require("go").setup({
        lsp_cfg = false,
        lsp_inlay_hints = {
          enable = false, -- disable go.nvim inlay as it is currently buggy.
          -- hint style, set to 'eol' for end-of-line hints, 'inlay' for inline hints
          -- inlay only avalible for 0.10.x
          style = "inlay",
        },
      })
    end,

    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },

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
        },
      },

      setup = {
        gopls = function(_, _)
          -- gopls = function(_, opts)
          -- NOTE: workaround for gopls not supporting semanticTokensProvider
          -- https://github.com/golang/go/issues/54531#issuecomment-1464982242
          require("lazyvim.util").lsp.on_attach(function(client, _)
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
          end)
        end,
      },
    },
  },

  -- create dynamic keymaps for go.
  {
    "folke/which-key.nvim",
    opts = function(_, _)
      local printf = require("plugins.util.printf").printf

      autocmd("Filetype", {
        group = go_keymaps,
        pattern = { "go", "gomod" },
        callback = function()
          vim.schedule(function()
            vim.keymap.set("n", "<leader>la", "<cmd>GoCodeAction<cr>", { buffer = true, desc = printf("Code Action") })
            vim.keymap.set("n", "<leader>ls", "<cmd>GoFillStruct<cr>", { buffer = true, desc = printf("Fill Struct") })
            vim.keymap.set("n", "<leader>ls", "<cmd>GoFillStruct<cr>", { buffer = true, desc = printf("Fill Struct") })
            vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, { buffer = true, desc = printf("Rename") })

            -- go tags.
            vim.keymap.set("n", "<leader>lTj",
              "<cmd>GoModifyTag -add-tags json -transform snakecase -add-options json=<cr>",
              { buffer = true, desc = printf("Add Tags snakecase No 'omitempty'") })
            vim.keymap.set("n", "<leader>lTa",
              "<cmd>GoModifyTag -add-tags json -transform camelcase -add-options json=<cr>",
              { buffer = true, desc = printf("Add Tags No 'omitempty'") })
            vim.keymap.set("n", "<leader>lTA", "<cmd>GoModifyTag -add-tags json -transform camelcase<cr>",
              { buffer = true, desc = printf("Add Tags") })
            vim.keymap.set("n", "<leader>lTr", "<cmd>GoRename<cr>", { buffer = true, desc = printf("Remove Tags") })
            vim.keymap.set("n", "<leader>lTr", "<cmd>GoRename<cr>", { buffer = true, desc = printf("Remove Tags") })

            -- go test.
            vim.keymap.set("n", "<leader>lta", "<cmd>GoAddTest<cr>",
              { buffer = true, desc = printf("Add Test for Current Func") })
            vim.keymap.set("n", "<leader>ltA", "<cmd>GoAddAllTest<cr>",
              { buffer = true, desc = printf("Add Test for all Func") })
            vim.keymap.set("n", "<leader>lte", "<cmd>GoAddExpTest<cr>",
              { buffer = true, desc = printf("Add Exported Func") })
            vim.keymap.set("n", "<leader>ltT", "<cmd>GoTest<cr>", { buffer = true, desc = printf("Test All") })
            vim.keymap.set("n", "<leader>ltt", "<cmd>GoTestFunc<cr>", { buffer = true, desc = printf("Test a Func") })
            vim.keymap.set("n", "<leader>ltF", "<cmd>GoTestFile<cr>",
              { buffer = true, desc = printf("Test All Func in the File") })
            vim.keymap.set("n", "<leader>ltP", "<cmd>GoTestPkg<cr>", { buffer = true, desc = printf("Test Package") })
            vim.keymap.set("n", "<leader>ltc", "<cmd>GoCoverage<cr>",
              { buffer = true, desc = printf("Test -coverprofile") })
            vim.keymap.set("n", "<leader>ld", "<cmd>GoDoc<cr>", { buffer = true, desc = printf("Go Doc") })
            vim.keymap.set("n", "<leader>le", "<cmd>GoIfErr<cr>",
              { buffer = true, desc = printf("Auto Generate 'if err'") })
            vim.keymap.set("n", "<leader>ll", "<cmd>GoLint<cr>", { buffer = true, desc = printf("Run 'golangci_lint'") })
            vim.keymap.set("n", "<leader>lm", "<cmd>Gomvp<cr>", { buffer = true, desc = printf("Rename Module name") })
            vim.keymap.set("n", "<leader>lc", "<cmd>GoCheat<cr>", { buffer = true, desc = printf("Cheatsheet") })
            vim.keymap.set("n", "<leader>lC", "<cmd>GoCmt<cr>",
              { buffer = true, desc = printf("Go Generate Func Comments") })
            -- -- map("n", "<leader>lgm", "<cmd>GoFixPlurals<cr>", { desc = printf"Go Fix Redundant Func Params" }) -- not working?

            -- goplay.nvim keymaps
            vim.keymap.set("n", "<leader>lpo", ":GPOpen<CR>", { buffer = true, desc = printf("Open Goplay") })
            vim.keymap.set("n", "<leader>lpt", ":GPToggle<CR>", { buffer = true, desc = printf("Toggle Goplay") })
            vim.keymap.set("n", "<leader>lpe", ":GPExec<CR>", { buffer = true, desc = printf("Execute") })
            vim.keymap.set("n", "<leader>lpE", ":GPExecFile<CR>", { buffer = true, desc = printf("Execute File") })
            vim.keymap.set("n", "<leader>lpc", ":GPClose<CR>", { buffer = true, desc = printf("Close Goplay") })
            vim.keymap.set("n", "<leader>lpC", ":GPClear<CR>", { buffer = true, desc = printf("Clear Goplay") })

            local wk = require("which-key")
            local opts = { prefix = "<leader>", buffer = 0 }
            local mappings = {
              { "<leader>l", icon = "󰟓", group = printf("lsp (go.nvim)"), mode = "n" },
              { "<leader>lT", icon = "󰟓", group = printf("tags"), mode = "n" },
              { "<leader>lt", icon = "󰟓", group = printf("test"), mode = "n" },
              { "<leader>lp", icon = "󰟓", group = printf("goplay.nvim"), mode = "n" },
            }

            wk.add(mappings, opts)
          end)
        end,
      })
    end,
  },

  {
    "rcarriga/nvim-notify",
    opts = function(_, _)
      -- create a notification when file is saved.
      local format_sync_grp = augroup("GoReminderPersonal", {})
      autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function()
          local notify = require("notify")

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
    end,
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
          vim.list_extend(opts.ensure_installed, { "gomodifytags", "impl", "goimports" })
          -- vim.list_extend(opts.ensure_installed, { "gomodifytags", "impl", "goimports", "delve" }) -- NOTE: disable delve as it will make dap has a lot of option and the nvim dap uses non mason delve package.
        end,
      },
      {
        "leoluz/nvim-dap-go",
        config = function()
          require("dap-go").setup()
        end,
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
          -- nls.builtins.code_actions.gomodifytags, -- FIX: not working. use go.nvim instead
          nls.builtins.code_actions.impl,
          -- nls.builtins.formatting.gofumpt,
          nls.builtins.formatting.gofmt,
          -- nls.builtins.formatting.goimports_reviser,
          nls.builtins.formatting.goimports,
        })
      end
    end,
  },

  -- {
  --   "stevearc/conform.nvim",
  --   optional = true,
  --   opts = {
  --     formatters_by_ft = {
  --       go = { "goimports", "gofmt" },
  --       -- go = { "goimports", "gofumpt" },
  --     },
  --   },
  -- },

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
        mode = "current",                               -- current/split/[vsplit] specifies where the playground will be opened
        -- mode = "vsplit", -- current/split/[vsplit] specifies where the playground will be opened
        playgroundDirName = "goplayground",             -- a name of the directory under GOPATH/src where the playground will be saved
        tempPlaygroundDirName = "goplayground_temp",    -- a name of the directory under GOPATH/src where the temporary playground will be saved. This option is used when you need to execute a file
        output_mode = "raw",                            -- [formatted]/raw mode to display output
        -- output_mode = "formatted", -- [formatted]/raw mode to display output
      })
    end,
  },

  {
    "echasnovski/mini.icons",
    opts = {
      file = {
        [".go-version"] = { glyph = "", hl = "MiniIconsBlue" },
      },
      filetype = {
        gotmpl = { glyph = "󰟓", hl = "MiniIconsGrey" },
      },
    },
  },

  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "fredrikaverpil/neotest-golang",
    },
    opts = {
      adapters = {
        ["neotest-golang"] = {
          -- Here we can set options for neotest-golang, e.g.
          -- go_test_args = { "-v", "-race", "-count=1", "-timeout=60s" },
          dap_go_enabled = true, -- requires leoluz/nvim-dap-go
        },
      },
    },
  },
}
