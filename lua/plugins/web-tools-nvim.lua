return {
  {
    "ray-x/web-tools.nvim",
    event = "VeryLazy",
    dependencies = {
      "ray-x/guihua.lua",
    },
    config = function(_, opts)
      -- to make Comment.nvim to be able to visual comment hurl file
      local loaded, ft = pcall(require, "Comment.ft")
      if loaded and ft then
        -- Set only line comment
        ft.set("hurl", "#%s")
      end

      require("web-tools").setup({
        keymaps = {
          rename = nil, -- by default use same setup of lspconfig
          repeat_rename = ".", -- . to repeat
        },
        hurl = { -- hurl default
          show_headers = false, -- do not show http headers
          -- show_headers = true, -- do not show http headers
          floating = true, -- use floating windows (need guihua.lua)
          -- NOTE: must install mason; jq, prettier, and html, else it will not show any float response
          formatters = { -- format the result by filetype
            json = { "jq" },
            html = { "prettier", "--parser", "html" },
          },
        },
      })

      local augroup = vim.api.nvim_create_augroup

      -- close some filetypes with <q>
      vim.api.nvim_create_autocmd("FileType", {
        group = augroup("close_with_q", { clear = true }),
        pattern = {
          "hurl",
          "json", -- for web-tools-nvim floating window
          "html", -- for web-tools-nvim floating window
          "guihua", -- for web-tools-nvim floating window
        },
        callback = function(event)
          vim.bo[event.buf].buflisted = false
          vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
        end,
      })
    end,
  },

  -- ensure_installed hurl and json treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- if type(opts.ensure_installed) == "table" then
      vim.list_extend(opts.ensure_installed, { "hurl", "json" })
      -- end
    end,
  },

  -- ensure_installed jq, prettier, html-lsp mason
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "html-lsp", "jq", "prettier" })
      end
    end,
  },
}
