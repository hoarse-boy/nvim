local myColor = {
  -- fujiWhite = "#40E0D0", -- variable
  springGreen = "#01AE78", -- string
  fujiGray = "#4d4b49", -- comments
  oniViolet = "#BF026D", -- func, defer etc. also affects var, let, local, anonym func in lua and js
  sakuraPink = "#f77e34", -- number
  -- sakuraPink = "#a249eb", -- number
  -- springBlue = "#b9fad7", -- nil, require, builtin func, and indent line
  peachRed = "#aa58ed", -- return and exception handling
  crystalBlue = "#4777d6", -- Functions and Titles
  -- crystalBlue = "#6590e6", -- Functions and Titles
  -- waveAqua2 = "#7f9e4d", -- types
  waveAqua2 = "#0fd1ce", -- types
  surimiOrange = "#a249eb", -- Constants, imports, booleans. also nil in golang
  -- surimiOrange = "#FFA066", -- Constants, imports, booleans. also nil in golang
}

return {
  "rebelot/kanagawa.nvim",
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    -- Default options:
    require("kanagawa").setup({
      undercurl = true, -- enable undercurls
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = true },
      statementStyle = { bold = true },
      typeStyle = { italic = true },
      variablebuiltinStyle = {},
      specialReturn = true, -- special highlight for the return keyword
      specialException = true, -- special highlight for exception handling keywords
      transparent = true, -- do not set background color
      -- transparent = false, -- do not set background color
      dimInactive = false, -- dim inactive window `:h hl-NormalNC`
      -- dimInactive = true, -- dim inactive window `:h hl-NormalNC`
      globalStatus = false, -- adjust window separators highlight for laststatus=3
      terminalColors = true, -- define vim.g.terminal_color_{0,17}
      colors = {
        theme = { all = { ui = { bg_gutter = "none" } } },
        palette = myColor,
      },

      -- NOTE: make the telescope not transparent
      -- overrides = function(colors)
      --   local theme = colors.theme
      --   return {
      --     TelescopeTitle = { fg = theme.ui.special, bold = true },
      --     TelescopePromptNormal = { bg = theme.ui.bg_p1 },
      --     TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
      --     TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
      --     TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
      --     TelescopePreviewNormal = { bg = theme.ui.bg_dim },
      --     TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
      --   }
      -- end,

      overrides = function(colors)
        local theme = colors.theme
        return {
          Pmenu = { blend = vim.o.pumblend }, -- TODO: what does it do?
          -- Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
          -- PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
          -- PmenuSbar = { bg = theme.ui.bg_m1 },
          -- PmenuThumb = { bg = theme.ui.bg_p2 },
          -- TelescopePromptNormal = { bg = theme.ui.bg_p1, blend = vim.o.pumblend },
          -- TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.pmenu.bg, blend = vim.o.pumblend },
          -- TelescopePreviewNormal = { bg = theme.ui.bg_dim, blend = vim.o.pumblend },
          -- TelescopeTitle = { fg = theme.ui.special, bold = true },
          -- TelescopePromptNormal = { bg = "none" },
          -- TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = "none" }, -- NOTE: fg changes the border line. in this case bg_p1 will make it less prominent
          -- TelescopeResultsNormal = { fg = theme.ui.bg_p1, bg = "none" },
          -- TelescopeResultsBorder = { fg = theme.ui.bg_p1, bg = "none" },
          -- TelescopePreviewNormal = { bg = "none" },
          -- TelescopePreviewBorder = { bg = "none", fg = theme.ui.bg_p1 },

          -- NOTE: the same as vim.cmd("highlight TelescopeBorder guibg=none") in layz.lua
          -- make the ugly border highlight diseapper
          -- TODO: add an if, if kanagawa transparent is true add above
          TelescopeBorder = { bg = "none" },
          FloatBorder = { bg = "none" },
          NormalFloat = { bg = "none" },
          TelescopeTitle = { bg = "none" },
          TelescopeNormal = { bg = "none" },
        }
      end,

      -- colors = myColor,
      -- overrides = {},
      -- theme = "default", -- Load "default" theme or the experimental "light" theme
    })
  end,
}
