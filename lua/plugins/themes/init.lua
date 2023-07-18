return {
  { require("plugins.themes.kanagawa") },
  { require("plugins.themes.starry") },
  { require("plugins.themes.aurora") },
  { require("plugins.themes.catppuccin") },
  { require("plugins.themes.tokyo-night") },
  { require("plugins.themes.nightfox") },
  { require("plugins.themes.vscode") },
  -- { "ellisonleao/gruvbox.nvim" },

  -- Configure LazyVim to load a theme
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "kanagawa", -- default theme
      colorscheme = "catppuccin",
      -- colorscheme = "vscode",
      -- colorscheme = "mariana",
      --Earlysummer
      -- colorscheme = "aurora",
      -- colorscheme = "kanagawa-lotus",

      -- colorscheme = "tokyonight",
      -- colorscheme = "nightfox",
    },
  },
}
