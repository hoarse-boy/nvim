return {
  -- Extend auto completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        "Saecki/crates.nvim",
        event = { "BufRead Cargo.toml" },
        config = true,
      },
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, {
        { name = "crates" },
      }))
    end,
  },

  -- Add Rust & related to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "ron", "rust", "toml" })
      end
    end,
  },

  -- Ensure Rust debugger is installed
  {
    "williamboman/mason.nvim",
    optional = true,
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "codelldb" })
      end
    end,
  },

  {
    "simrat39/rust-tools.nvim",
    lazy = true,
    opts = function()
      local ok, mason_registry = pcall(require, "mason-registry")
      local adapter ---@type any
      if ok then
        -- rust tools configuration for debugging support
        local codelldb = mason_registry.get_package("codelldb")
        local extension_path = codelldb:get_install_path() .. "/extension/"
        local codelldb_path = extension_path .. "adapter/codelldb"
        local liblldb_path = ""
        if vim.loop.os_uname().sysname:find("Windows") then
          liblldb_path = extension_path .. "lldb\\bin\\liblldb.dll"
        elseif vim.fn.has("mac") == 1 then
          liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
        else
          liblldb_path = extension_path .. "lldb/lib/liblldb.so"
        end
        adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)
      end
      return {
        dap = {
          adapter = adapter,
        },
        tools = {
          on_initialized = function()
            vim.cmd([[
                  augroup RustLSP
                    autocmd CursorHold                      *.rs silent! lua vim.lsp.buf.document_highlight()
                    autocmd CursorMoved,InsertEnter         *.rs silent! lua vim.lsp.buf.clear_references()
                    autocmd BufEnter,CursorHold,InsertLeave *.rs silent! lua vim.lsp.codelens.refresh()
                  augroup END
                ]])
          end,
        },
      }
    end,
    config = function()
      require("lazyvim.util").lsp.on_attach(function(client, buffer)
        if client.name == "rust_analyzer" then
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
              name = "+lsp (Rust)",
              m = {
                name = "+item",
              },
            },
          }

          wk.register(mappings, opts)
        end
      end)
    end,
  },

  -- Correctly setup lspconfig for Rust 🚀
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Ensure mason installs the server
        rust_analyzer = {
          keys = {
            { "K", "<cmd>RustHoverActions<cr>", desc = "Hover Actions (Rust)" },
            { "<leader>cA", "<cmd>RustCodeAction<cr>", desc = "Code Action (Rust)" }, -- FIX: check if it duplicated
            { "<leader>dr", "<cmd>RustDebuggables<cr>", desc = "Run Debuggables (Rust)" },
            { "<leader>l", "", desc = "+ Lsp (Rust)" },
            { "<leader>lc", "<cmd>RustOpenCargo<cr>", desc = "Open Cargo (Rust)" },
            { "<leader>lmu", "<cmd>RustMoveItemUp<cr>", desc = "Move Item Up (Rust)" },
            { "<leader>lmd", "<cmd>RustMoveItemDown<cr>", desc = "Move Item Down (Rust)" },
            { "<leader>lr", "<cmd>RustHoverRange<cr>", desc = "Hover Range (Rust)" },
            { "<leader>lp", "<cmd>RustParentModule<cr>", desc = "Go to Parent Module (Rust)" },
            { "<leader>lj", "<cmd>RustJoinLines<cr>", desc = "Join Line(Rust)" },
            -- TODO: RustSSR [query]
            -- RustViewCrateGraph [backend [output]]
          },
          settings = {
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                runBuildScripts = true,
              },
              -- Add clippy lints for Rust.
              checkOnSave = {
                allFeatures = true,
                command = "clippy",
                extraArgs = { "--no-deps" },
              },
              procMacro = {
                enable = true,
                ignored = {
                  ["async-trait"] = { "async_trait" },
                  ["napi-derive"] = { "napi" },
                  ["async-recursion"] = { "async_recursion" },
                },
              },
            },
          },
        },
        taplo = {
          keys = {
            {
              "K",
              function()
                if vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
                  require("crates").show_popup()
                else
                  vim.lsp.buf.hover()
                end
              end,
              desc = "Show Crate Documentation",
            },
          },
        },
      },
      setup = {
        rust_analyzer = function(_, opts)
          local rust_tools_opts = require("lazyvim.util").opts("rust-tools.nvim")
          require("rust-tools").setup(vim.tbl_deep_extend("force", rust_tools_opts or {}, { server = opts }))
          return true
        end,
      },
    },
  },

  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "rouge8/neotest-rust",
    },
    opts = {
      adapters = {
        ["neotest-rust"] = {},
      },
    },
  },
}

-- TODO: remove alot of this code to use opts only to add keymaps or other. will use lazyvim rust config
-- return {
--   -- Extend auto completion
--   {
--     "hrsh7th/nvim-cmp",
--     dependencies = {
--       {
--         "Saecki/crates.nvim",
--         event = { "BufRead Cargo.toml" },
--         config = true,
--       },
--     },
--     ---@param opts cmp.ConfigSchema
--     opts = function(_, opts)
--       local cmp = require("cmp")
--       opts.sources = cmp.config.sources(vim.list_extend(opts.sources, {
--         { name = "crates" },
--       }))
--     end,
--   },

--   -- Add Rust & related to treesitter
--   {
--     "nvim-treesitter/nvim-treesitter",
--     opts = function(_, opts)
--       if type(opts.ensure_installed) == "table" then
--         vim.list_extend(opts.ensure_installed, { "ron", "rust", "toml" })
--       end
--     end,
--   },

--   -- Ensure Rust debugger is installed
--   {
--     "williamboman/mason.nvim",
--     optional = true,
--     opts = function(_, opts)
--       if type(opts.ensure_installed) == "table" then
--         vim.list_extend(opts.ensure_installed, { "codelldb" })
--       end
--     end,
--   },

--   {
--     "simrat39/rust-tools.nvim",
--     lazy = true,
--     opts = function()
--       local ok, mason_registry = pcall(require, "mason-registry")
--       local adapter ---@type any
--       if ok then
--         -- rust tools configuration for debugging support
--         local codelldb = mason_registry.get_package("codelldb")
--         local extension_path = codelldb:get_install_path() .. "/extension/"
--         local codelldb_path = extension_path .. "adapter/codelldb"
--         local liblldb_path = vim.fn.has("mac") == 1 and extension_path .. "lldb/lib/liblldb.dylib"
--           or extension_path .. "lldb/lib/liblldb.so"
--         adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)
--       end
--       return {
--         dap = {
--           adapter = adapter,
--         },
--         tools = {
--           on_initialized = function()
--             vim.cmd([[
--                   augroup RustLSP
--                     autocmd CursorHold                      *.rs silent! lua vim.lsp.buf.document_highlight()
--                     autocmd CursorMoved,InsertEnter         *.rs silent! lua vim.lsp.buf.clear_references()
--                     autocmd BufEnter,CursorHold,InsertLeave *.rs silent! lua vim.lsp.codelens.refresh()
--                   augroup END
--                 ]])
--           end,
--         },
--       }
--     end,
--     config = function() end,
--   },

--   -- Correctly setup lspconfig for Rust 🚀
--   {
--     "neovim/nvim-lspconfig",
--     opts = {
--       servers = {
--         -- Ensure mason installs the server
--         rust_analyzer = {
--           keys = {
--             { "K", "<cmd>RustHoverActions<cr>", desc = "Hover Actions (Rust)" },
--             { "<leader>cR", "<cmd>RustCodeAction<cr>", desc = "Code Action (Rust)" },
--             { "<leader>dr", "<cmd>RustDebuggables<cr>", desc = "Run Debuggables (Rust)" },
--           },
--           settings = {
--             ["rust-analyzer"] = {
--               cargo = {
--                 allFeatures = true,
--                 loadOutDirsFromCheck = true,
--                 runBuildScripts = true,
--               },
--               -- Add clippy lints for Rust.
--               checkOnSave = {
--                 allFeatures = true,
--                 command = "clippy",
--                 extraArgs = { "--no-deps" },
--               },
--               procMacro = {
--                 enable = true,
--                 ignored = {
--                   ["async-trait"] = { "async_trait" },
--                   ["napi-derive"] = { "napi" },
--                   ["async-recursion"] = { "async_recursion" },
--                 },
--               },
--             },
--           },
--         },
--         taplo = {
--           keys = {
--             {
--               "K",
--               function()
--                 if vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
--                   require("crates").show_popup()
--                 else
--                   vim.lsp.buf.hover()
--                 end
--               end,
--               desc = "Show Crate Documentation",
--             },
--           },
--         },
--       },
--       setup = {
--         rust_analyzer = function(_, opts)
--           local rust_tools_opts = require("lazyvim.util").opts("rust-tools.nvim")
--           require("rust-tools").setup(vim.tbl_deep_extend("force", rust_tools_opts or {}, { server = opts }))
--           return true
--         end,
--       },
--     },
--   },

--   {
--     "nvim-neotest/neotest",
--     optional = true,
--     dependencies = {
--       "rouge8/neotest-rust",
--     },
--     opts = {
--       adapters = {
--         ["neotest-rust"] = {},
--       },
--     },
--   },
-- }
-- return {
--   {
--     "neovim/nvim-lspconfig",
--     opts = {
--       servers = {
--         -- Ensure mason installs the server
--         rust_analyzer = {
--           keys = {
--             { "K", "<cmd>RustHoverActions<cr>", desc = "Hover Actions (Rust)" },
--             { "<leader>cR", "<cmd>RustCodeAction<cr>", desc = "Code Action (Rust)" },
--             { "<leader>dr", "<cmd>RustDebuggables<cr>", desc = "Run Debuggables (Rust)" },
--           },
--           settings = {
--             ["rust-analyzer"] = {
--               cargo = {
--                 allFeatures = true,
--                 loadOutDirsFromCheck = true,
--                 runBuildScripts = true,
--               },
--               semanticHighlighting = {
--                 strings = {
--                   enable = true,
--                 },
--                 -- punctuation = {
--                 --   enable = true,
--                 -- },
--               },
--               -- Add clippy lints for Rust.
--               checkOnSave = {
--                 allFeatures = true,
--                 command = "clippy",
--                 extraArgs = { "--no-deps" },
--               },
--               procMacro = {
--                 enable = true,
--                 ignored = {
--                   ["async-trait"] = { "async_trait" },
--                   ["napi-derive"] = { "napi" },
--                   ["async-recursion"] = { "async_recursion" },
--                 },
--               },
--             },
--           },
--         },
--         taplo = {
--           keys = {
--             {
--               "K",
--               function()
--                 if vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
--                   require("crates").show_popup()
--                 else
--                   vim.lsp.buf.hover()
--                 end
--               end,
--               desc = "Show Crate Documentation",
--             },
--           },
--         },
--       },
--       setup = {
--         rust_analyzer = function(_, opts)
--           local rust_tools_opts = require("lazyvim.util").opts("rust-tools.nvim")
--           require("rust-tools").setup(vim.tbl_deep_extend("force", rust_tools_opts or {}, { server = opts }))
--           return true
--         end,
--       },
--     },
--   },
-- }

-- TODO: this is the latest setup code. dont need to check for lsp using on_attach func.
-- add keymaps like 'keys' below.
-- -- Correctly setup lspconfig for Rust 🚀
-- {
--   "neovim/nvim-lspconfig",
--   opts = {
--     servers = {
--       -- Ensure mason installs the server
--       rust_analyzer = {
--         keys = {
--           { "K", "<cmd>RustHoverActions<cr>", desc = "Hover Actions (Rust)" },
--           { "<leader>cR", "<cmd>RustCodeAction<cr>", desc = "Code Action (Rust)" },
--           { "<leader>dr", "<cmd>RustDebuggables<cr>", desc = "Run Debuggables (Rust)" },
--         },
--         settings = {
--           ["rust-analyzer"] = {
--             cargo = {
--               allFeatures = true,
--               loadOutDirsFromCheck = true,
--               runBuildScripts = true,
--             },
--             -- Add clippy lints for Rust.
--             checkOnSave = {
--               allFeatures = true,
--               command = "clippy",
--               extraArgs = { "--no-deps" },
--             },
--             procMacro = {
--               enable = true,
--               ignored = {
--                 ["async-trait"] = { "async_trait" },
--                 ["napi-derive"] = { "napi" },
--                 ["async-recursion"] = { "async_recursion" },
--               },
--             },
--           },
--         },
--       },
--       taplo = {
--         keys = {
--           {
--             "K",
--             function()
--               if vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
--                 require("crates").show_popup()
--               else
--                 vim.lsp.buf.hover()
--               end
--             end,
--             desc = "Show Crate Documentation",
--           },
--         },
--       },
--     },
--     setup = {
--       rust_analyzer = function(_, opts)
--         local rust_tools_opts = require("lazyvim.util").opts("rust-tools.nvim")
--         require("rust-tools").setup(vim.tbl_deep_extend("force", rust_tools_opts or {}, { server = opts }))
--         return true
--       end,
--     },
--   },
-- },
