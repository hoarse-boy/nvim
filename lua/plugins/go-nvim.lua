-- NOTE: this go plugin is much better than vim-go by fatih as it uses the modern lua and by default integrated with nvim-lspconfig
-- no hassle with duplicate gopls server in memory
-- https://github.com/ray-x/go.nvim?ref=morioh.com&utm_source=morioh.com
return {
  "ray-x/go.nvim",
  dependencies = { -- optional packages
    "ray-x/guihua.lua",
    -- "neovim/nvim-lspconfig",
    -- "nvim-treesitter/nvim-treesitter",
  },

  config = function()
    require("go").setup()
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
