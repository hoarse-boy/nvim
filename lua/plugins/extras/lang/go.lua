return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      -- "neovim/nvim-lspconfig",
      -- "nvim-treesitter/nvim-treesitter",
    },

    -- build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
  },

  -- event = { "CmdlineEnter" },
  -- ft = { "go", "gomod" },

  opts = {
    servers = {
      -- gopls = {},
      gopls = {
        cmd = { "gopls", "serve" },
        filetypes = { "go", "gomod" },
        -- root_dir = util.root_pattern("go.work", "go.mod", ".git"),
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
            },
            staticcheck = true,
          },
        },
      },
    },

    setup = {
      gopls = function(_, opts)
        require("lazyvim.util").on_attach(function(client, buffer)
          if client.name == "gopls" then
            print("kabommm")
            print("kabom", client.name)
            -- FIX: move this to go.lua in extras/lang to make it check if the file is golang to shows this key. else remove it
            -- use leader lc ? for all lauguage?
            -- for example if  the buffer is *.go make it appear as lc of all golang keys
            -- and if the file is *.rs make it appear of rust keys only?
            -- go-nvim

                -- stylua: ignore
            vim.keymap.set("n", "<leader>cs", "<cmd>GoFillStruct<cr>", {buffer = buffer, desc = "Go Fill Struct" })
            vim.keymap.set("n", "<leader>cf", "<cmd>GoFillSwitch<cr>", { buffer = buffer, desc = "Go Fill Switch" })
            vim.keymap.set("n", "<leader>ct", "<cmd>GoAddTag<cr>", { buffer = buffer, desc = "Go Add Tags" })
            vim.keymap.set("n", "<leader>cr", "<cmd>GoRmTag<cr>", { buffer = buffer, desc = "Go Remove Tags" })
            -- stylua: ignore
            vim.keymap.set( "n", "<leader>cT", "<cmd>GoTestFun<cr>", { buffer = buffer, desc = "Go Test a Function" })
            vim.keymap.set("n", "<leader>cA", "<cmd>GoTestPkg<cr>", { buffer = buffer, desc = "Go Test Package" })
            -- stylua: ignore
            vim.keymap.set("n", "<leader>ce", "<cmd>GoIfErr<cr>", { buffer = buffer, desc = "Go Auto Generate 'if err'" })
            -- stylua: ignore
            vim.keymap.set( "n", "<leader>cc", "<cmd>GoCmt<cr>", { buffer = buffer, desc = "Go Generate Func Comments" })
            vim.keymap.set("n", "<leader>cm", "<cmd>Gomvp<cr>", { buffer = buffer, desc = "Go Rename Module name" })
            -- stylua: ignore
            vim.keymap.set( "n", "<leader>cm", "<cmd>GoFixPlurals<cr>", { buffer = buffer, desc = "Go Fix Redundant Func Params" }) -- not working?
            -- stylua: ignore
            vim.keymap.set("n", "<leader>co", "<cmd>TypescriptOrganizeImports<CR>", { buffer = buffer, desc = "Organize Imports" })
            --
            --   vim.keymap.set("n", "<leader>cR", "<cmd>TypescriptRenameFile<CR>", { desc = "Rename File", buffer = buffer })
          end
        end)
        require("go").setup({ server = opts }) -- FIX:
        return true
      end,
    },
  },
}

-- return {
--   "ray-x/go.nvim",
--   dependencies = { -- optional packages
--     "ray-x/guihua.lua",

--     {
--       "neovim/nvim-lspconfig",

--       -- setup = {
--       --   gopls = function(_, opts)
--       --     require("lazyvim.util").on_attach(function(client, buffer)
--       --       if client.name == "gopls" then
--       --     -- if client.name == "go" then

--       --       -- FIX: move this to go.lua in extras/lang to make it check if the file is golang to shows this key. else remove it
--       --       -- use leader lc ? for all lauguage?
--       --       -- for example if  the buffer is *.go make it appear as lc of all golang keys
--       --       -- and if the file is *.rs make it appear of rust keys only?
--       --       -- go-nvim

--       --       -- stylua: ignore
--       --       vim.keymap.set("n", "<leader>cs", "<cmd>GoFillStruct<cr>", {buffer = buffer, desc = "Go Fill Struct" })
--       --         vim.keymap.set("n", "<leader>cf", "<cmd>GoFillSwitch<cr>", { buffer = buffer, desc = "Go Fill Switch" })
--       --         vim.keymap.set("n", "<leader>ct", "<cmd>GoAddTag<cr>", { buffer = buffer, desc = "Go Add Tags" })
--       --         vim.keymap.set("n", "<leader>cr", "<cmd>GoRmTag<cr>", { buffer = buffer, desc = "Go Remove Tags" })
--       --         vim.keymap.set("n", "<leader>cT", "<cmd>GoTestFun<cr>", { buffer = buffer, desc = "Go Test a Function" })
--       --         vim.keymap.set("n", "<leader>cA", "<cmd>GoTestPkg<cr>", { buffer = buffer, desc = "Go Test Package" })
--       --       -- stylua: ignore
--       --       vim.keymap.set("n", "<leader>ce", "<cmd>GoIfErr<cr>", { buffer = buffer, desc = "Go Auto Generate 'if err'" })
--       --         vim.keymap.set(
--       --           "n",
--       --           "<leader>cc",
--       --           "<cmd>GoCmt<cr>",
--       --           { buffer = buffer, desc = "Go Generate Func Comments" }
--       --         )
--       --         vim.keymap.set("n", "<leader>cm", "<cmd>Gomvp<cr>", { buffer = buffer, desc = "Go Rename Module name" })
--       --       -- stylua: ignore
--       --       vim.keymap.set( "n", "<leader>cm", "<cmd>GoFixPlurals<cr>", { buffer = buffer, desc = "Go Fix Redundant Func Params" }) -- not working?
--       --       -- stylua: ignore
--       --       vim.keymap.set("n", "<leader>co", "<cmd>TypescriptOrganizeImports<CR>", { buffer = buffer, desc = "Organize Imports" })
--       --         --
--       --         --   vim.keymap.set("n", "<leader>cR", "<cmd>TypescriptRenameFile<CR>", { desc = "Rename File", buffer = buffer })
--       --       end
--       --     end)
--       --     require("go").setup({ server = opts }) -- FIX:

--       --     -- require("go").setup()
--       --     return true
--       --   end,
--       -- },
--     },

--     "nvim-treesitter/nvim-treesitter",
--   },

--   setup = {
--     gopls = function(_, opts)
--       require("lazyvim.util").on_attach(function(client, buffer)
--         if client.name == "gopls" then
--           print("kabommmm")
--         -- if client.name == "go" then

--             -- FIX: move this to go.lua in extras/lang to make it check if the file is golang to shows this key. else remove it
--             -- use leader lc ? for all lauguage?
--             -- for example if  the buffer is *.go make it appear as lc of all golang keys
--             -- and if the file is *.rs make it appear of rust keys only?
--             -- go-nvim

--             -- stylua: ignore
--             vim.keymap.set("n", "<leader>cs", "<cmd>GoFillStruct<cr>", {buffer = buffer, desc = "Go Fill Struct" })
--           vim.keymap.set("n", "<leader>cf", "<cmd>GoFillSwitch<cr>", { buffer = buffer, desc = "Go Fill Switch" })
--           vim.keymap.set("n", "<leader>ct", "<cmd>GoAddTag<cr>", { buffer = buffer, desc = "Go Add Tags" })
--           vim.keymap.set("n", "<leader>cr", "<cmd>GoRmTag<cr>", { buffer = buffer, desc = "Go Remove Tags" })
--           vim.keymap.set("n", "<leader>cT", "<cmd>GoTestFun<cr>", { buffer = buffer, desc = "Go Test a Function" })
--           vim.keymap.set("n", "<leader>cA", "<cmd>GoTestPkg<cr>", { buffer = buffer, desc = "Go Test Package" })
--             -- stylua: ignore
--             vim.keymap.set("n", "<leader>ce", "<cmd>GoIfErr<cr>", { buffer = buffer, desc = "Go Auto Generate 'if err'" })
--           vim.keymap.set("n", "<leader>cc", "<cmd>GoCmt<cr>", { buffer = buffer, desc = "Go Generate Func Comments" })
--           vim.keymap.set("n", "<leader>cm", "<cmd>Gomvp<cr>", { buffer = buffer, desc = "Go Rename Module name" })
--             -- stylua: ignore
--             vim.keymap.set( "n", "<leader>cm", "<cmd>GoFixPlurals<cr>", { buffer = buffer, desc = "Go Fix Redundant Func Params" }) -- not working?
--             -- stylua: ignore
--             vim.keymap.set("n", "<leader>co", "<cmd>TypescriptOrganizeImports<CR>", { buffer = buffer, desc = "Organize Imports" })
--           --
--           --   vim.keymap.set("n", "<leader>cR", "<cmd>TypescriptRenameFile<CR>", { desc = "Rename File", buffer = buffer })
--         end
--       end)
--       require("go").setup({ server = opts }) -- FIX:

--       -- require("go").setup()
--       return true
--     end,
--   },

--   -- config = function()
--   --   require("go").setup()
--   -- end,
--   event = { "CmdlineEnter" },
--   ft = { "go", "gomod" },
--   -- build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
-- }
