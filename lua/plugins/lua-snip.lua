local vscode_path = "~/.config/nvim/lua/vscode-snippets"
local snipmate_path = "~/.config/nvim/lua/snippets"
-- community driven of all programing language snippets
local honza_snippets_path = "~/.local/share/nvim/lazy/vim-snippets/snippets"

local friendly_snippets = {
  "rafamadriz/friendly-snippets",
  config = function()
    require("luasnip.loaders.from_snipmate").lazy_load({ paths = snipmate_path })
    require("luasnip.loaders.from_vscode").lazy_load({ paths = vscode_path })
    require("luasnip.loaders.from_snipmate").lazy_load({ paths = honza_snippets_path })
  end,
}

return {
  "L3MON4D3/LuaSnip",
  dependencies = {
    friendly_snippets,
    -- install honza's communty driven snippets. copy the path and use require 'from_snipmate' above to load it.
    { "honza/vim-snippets" },
  },
  opts = {
    history = true,
    delete_check_events = "TextChanged",
  },
    -- stylua: ignore
    keys = {
      {
        "<tab>",
        function()
          return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
        end,
        expr = true, silent = true, mode = "i",
      },
      { "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
      { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
    },
}
