return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-calc",
    },

    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local luasnip = require("luasnip")
      local cmp = require("cmp")

      opts.window = {
        completion = {
          winblend = 0, -- make it transparent
          border = "rounded",
          winhighlight = "Normal:CmpNormal",
        },
        documentation = {
          winblend = 0, -- make it transparent
          border = "rounded",
          winhighlight = "Normal:CmpDocNormal",
        },
      }

      -- NOTE: to overwrite sources, just use opts.something. and dont add vim.list_extend
      -- higher first in table has more priority
      opts.sources = cmp.config.sources({
        { name = "luasnip" },
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "calc" },
        { name = "emoji" },
        { name = "path" },
      })

      -- NOTE: this will fix gopls strange behavior in which it will go to the middle of cmp suggestions instead of the first in line
      opts.preselect = cmp.PreselectMode.None
      opts.completion = { completeopt = "menu,menuone,noinsert,noselect" }

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<esc>"] = cmp.mapping.abort(), -- default is control + e
        ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<S-CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.

        -- add tab and shift tab to navigate the autocompleteion
        -- NOTE: use arrow keys to select cmp suggestion. tab will be solely used by lausnip until the luasnip placeholder are gone
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.jumpable() then
            luasnip.jump(1)
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      })
    end,
  },
}
