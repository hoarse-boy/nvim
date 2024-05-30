return {
  {
    "cameron-wags/rainbow_csv.nvim",
    event = "VeryLazy",
    config = true,
    ft = {
      "csv",
      "tsv",
      "csv_semicolon",
      "csv_whitespace",
      "csv_pipe",
      "rfc_csv",
      "rfc_semicolon",
    },
    cmd = {
      "RainbowDelim",
      "RainbowDelimSimple",
      "RainbowDelimQuoted",
      "RainbowMultiDelim",
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "csv" })
      end

      -- disable csv highlighting as the treesitter has auto install. use the rainbow_csv.nvim highlighting instead.
      if type(opts.highlight.disable) == "table" then
        vim.list_extend(opts.highlight.disable, { "csv" })
      else
        opts.highlight.disable = { "csv" }
      end
    end,
  }
}
