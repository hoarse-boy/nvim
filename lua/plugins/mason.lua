return {
  "williamboman/mason.nvim",
  -- keys = { { "<leader>cm", false } },
  opts = {
    ensure_installed = {
      "gopls",
      "rust-analyzer",
    },
  },
}
