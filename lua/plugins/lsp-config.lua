-- to change the keymaps of lspconfig use init (https://www.lazyvim.org/plugins/lsp#%EF%B8%8F-customizing-lsp-keymaps)
-- NOTE: only for lspconfig, will define the keymaps here, else will be in lua.config.keymaps folder
return {
  -- LSP keymaps
  "neovim/nvim-lspconfig",
  -- event = { "BufReadPre", "BufNewFile" }, -- default
  event = { "VeryLazy" }, -- overwrite default from lazyvim to start in root dir when launch nvim
  init = function()
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
    -- keys[#keys + 1] = { "<leader>li", "<cmd>LspInfo<cr>", desc = "Lsp Info" }
    -- keys[#keys + 1] = { "<leader>lI", "<cmd>Mason<cr>", desc = "Mason Info" }
    keys[#keys + 1] = { "<leader>cR", "<cmd>LspRestart<CR>", desc = "Restart Lsp" }

    -- NOTE: not working
    -- local format = require("lazyvim.plugins.lsp.format").format
    -- keys[#keys + 1] = { "<leader>lf", format, desc = "Format Document", has = "documentFormatting" }
    -- keys[#keys + 1] = { "<leader>lf", format, desc = "Format Range", mode = "v", has = "documentRangeFormatting" }

    -- swap the <leader>cd to gl line diagnostic
    keys[#keys + 1] = { "gl", vim.diagnostic.open_float, desc = "Line Diagnostics" }

    -- diagnostic
    local bufer_diagnostic = "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>"
    keys[#keys + 1] = { "<leader>cd", bufer_diagnostic, desc = "Buffer Diagnostics" }

    local workspace_diagnostic = "<cmd>Telescope diagnostics<cr>"
    keys[#keys + 1] = { "<leader>cD", workspace_diagnostic, desc = "Workspace Diagnostics" }

    --   keys[#keys + 1] =
    --     { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" }, has = "codeAction" }

    --   if require("lazyvim.util").has("inc-rename.nvim") then
    --     keys[#keys + 1] = {
    --       "<leader>lr",
    --       function()
    --         require("inc_rename")
    --         return ":IncRename " .. vim.fn.expand("<cword>")
    --       end,
    --       expr = true,
    --       desc = "Rename",
    --       has = "rename",
    --     }
    --   else
    --     keys[#keys + 1] = { "<leader>lr", vim.lsp.buf.rename, desc = "Rename", has = "rename" }
    --   end
  end,
  opts = function(_, _)
    vim.diagnostic.config({
      float = { border = "rounded" },
    })
  end,
}

-- {
--     "neovim/nvim-lspconfig",
--     event = { "BufReadPre", "BufNewFile" },
--     dependencies = {
--       { "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
--       { "folke/neodev.nvim", opts = {} },
--       "mason.nvim",
--       "williamboman/mason-lspconfig.nvim",
--       {
--         "hrsh7th/cmp-nvim-lsp",
--         cond = function()
--           return require("lazyvim.util").has("nvim-cmp")
--         end,
--       },
--     },
--     ---@class PluginLspOpts
--     opts = {
--       -- options for vim.diagnostic.config()
--       diagnostics = {
--         underline = true,
--         update_in_insert = false,
--         virtual_text = {
--           spacing = 4,
--           source = "if_many",
--           prefix = "●",
--           -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
--           -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
--           -- prefix = "icons",
--         },
--         severity_sort = true,
--       },
--       -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
--       -- Be aware that you also will need to properly configure your LSP server to
--       -- provide the inlay hints.
--       inlay_hints = {
--         enabled = false,
--       },
--       -- add any global capabilities here
--       capabilities = {},
--       -- Automatically format on save
--       autoformat = true,
--       -- Enable this to show formatters used in a notification
--       -- Useful for debugging formatter issues
--       format_notify = false,
--       -- options for vim.lsp.buf.format
--       -- `bufnr` and `filter` is handled by the LazyVim formatter,
--       -- but can be also overridden when specified
--       format = {
--         formatting_options = nil,
--         timeout_ms = nil,
--       },
--       -- LSP Server Settings
--       ---@type lspconfig.options
--       servers = {
--         jsonls = {},
--         lua_ls = {
--           -- mason = false, -- set to false if you don't want this server to be installed with mason
--           -- Use this to add any additional keymaps
--           -- for specific lsp servers
--           ---@type LazyKeys[]
--           -- keys = {},
--           settings = {
--             Lua = {
--               workspace = {
--                 checkThirdParty = false,
--               },
--               completion = {
--                 callSnippet = "Replace",
--               },
--             },
--           },
--         },
--       },
--       -- you can do any additional lsp server setup here
--       -- return true if you don't want this server to be setup with lspconfig
--       ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
--       setup = {
--         -- example to setup with typescript.nvim
--         -- tsserver = function(_, opts)
--         --   require("typescript").setup({ server = opts })
--         --   return true
--         -- end,
--         -- Specify * to use this function as a fallback for any server
--         -- ["*"] = function(server, opts) end,
--       },
--     },
--     ---@param opts PluginLspOpts
--     config = function(_, opts)
--       local Util = require("lazyvim.util")

--       if Util.has("neoconf.nvim") then
--         local plugin = require("lazy.core.config").spec.plugins["neoconf.nvim"]
--         require("neoconf").setup(require("lazy.core.plugin").values(plugin, "opts", false))
--       end
--       -- setup autoformat
--       require("lazyvim.plugins.lsp.format").setup(opts)
--       -- setup formatting and keymaps
--       Util.on_attach(function(client, buffer)
--         require("lazyvim.plugins.lsp.keymaps").on_attach(client, buffer)
--       end)

--       local register_capability = vim.lsp.handlers["client/registerCapability"]

--       vim.lsp.handlers["client/registerCapability"] = function(err, res, ctx)
--         local ret = register_capability(err, res, ctx)
--         local client_id = ctx.client_id
--         ---@type lsp.Client
--         local client = vim.lsp.get_client_by_id(client_id)
--         local buffer = vim.api.nvim_get_current_buf()
--         require("lazyvim.plugins.lsp.keymaps").on_attach(client, buffer)
--         return ret
--       end

--       -- diagnostics
--       for name, icon in pairs(require("lazyvim.config").icons.diagnostics) do
--         name = "DiagnosticSign" .. name
--         vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
--       end

--       local inlay_hint = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint

--       if opts.inlay_hints.enabled and inlay_hint then
--         Util.on_attach(function(client, buffer)
--           if client.supports_method('textDocument/inlayHint') then
--             inlay_hint(buffer, true)
--           end
--         end)
--       end

--       if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
--         opts.diagnostics.virtual_text.prefix = vim.fn.has("nvim-0.10.0") == 0 and "●"
--           or function(diagnostic)
--             local icons = require("lazyvim.config").icons.diagnostics
--             for d, icon in pairs(icons) do
--               if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
--                 return icon
--               end
--             end
--           end
--       end

--       vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

--       local servers = opts.servers
--       local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
--       local capabilities = vim.tbl_deep_extend(
--         "force",
--         {},
--         vim.lsp.protocol.make_client_capabilities(),
--         has_cmp and cmp_nvim_lsp.default_capabilities() or {},
--         opts.capabilities or {}
--       )

--       local function setup(server)
--         local server_opts = vim.tbl_deep_extend("force", {
--           capabilities = vim.deepcopy(capabilities),
--         }, servers[server] or {})

--         if opts.setup[server] then
--           if opts.setup[server](server, server_opts) then
--             return
--           end
--         elseif opts.setup["*"] then
--           if opts.setup["*"](server, server_opts) then
--             return
--           end
--         end
--         require("lspconfig")[server].setup(server_opts)
--       end

--       -- get all the servers that are available through mason-lspconfig
--       local have_mason, mlsp = pcall(require, "mason-lspconfig")
--       local all_mslp_servers = {}
--       if have_mason then
--         all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
--       end

--       local ensure_installed = {} ---@type string[]
--       for server, server_opts in pairs(servers) do
--         if server_opts then
--           server_opts = server_opts == true and {} or server_opts
--           -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
--           if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
--             setup(server)
--           else
--             ensure_installed[#ensure_installed + 1] = server
--           end
--         end
--       end

--       if have_mason then
--         mlsp.setup({ ensure_installed = ensure_installed, handlers = { setup } })
--       end

--       if Util.lsp_get_config("denols") and Util.lsp_get_config("tsserver") then
--         local is_deno = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc")
--         Util.lsp_disable("tsserver", is_deno)
--         Util.lsp_disable("denols", function(root_dir)
--           return not is_deno(root_dir)
--         end)
--       end
--     end,
--   }
