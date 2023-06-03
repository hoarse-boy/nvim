return {
  -- { "p00f/nvim-ts-rainbow" }, -- the original rainbow still works fine
  -- { "HiPhish/nvim-ts-rainbow2" },

  -- NOTE: doesnt use ts context. use context.vim instead
  { "nvim-treesitter/nvim-treesitter-context" }, -- no lazy load as it will not works
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      { "p00f/nvim-ts-rainbow" }, -- the original rainbow still works fine
    },
    opts = {
      highlight = {
        enable = true,
        -- NOTE: 'disable' will be moved to each language config in /extra/go for example
        -- disable = { "go" }, -- NOTE: disable go TS to use vim-go-syntx highlight instead but still uses the ts plugins like  ts-rainbow and context
      },
      rainbow = {
        enable = true,
        -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = nil, -- Do not enable for files with more than n lines, int
        -- colors = {}, -- table of hex strings
        -- termcolors = {} -- table of colour name strings
      },
      -- rainbow = {
      --   enable = true,
      --   -- list of languages you want to disable the plugin for
      --   -- disable = { "jsx", "cpp" },
      --   -- Which query to use for finding delimiters
      --   query = "rainbow-parens",
      --   -- Highlight the entire buffer all at once
      --   strategy = require("ts-rainbow.strategy.global"),
      --   -- Do not enable for files with more than n lines
      --   max_file_lines = 3000,
      -- },
    },
  },
}
