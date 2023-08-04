return {
  "kevinhwang91/nvim-ufo",
  event = "VeryLazy",
  -- enabled = false, -- disabled plugin
  dependencies = { "kevinhwang91/promise-async" },
  init = function()
    vim.o.foldcolumn = "0" -- '0' is not bad. will not show the complex number and symbol on the left side of current symbol and no.
    -- vim.o.foldcolumn = "1" -- '0' is not bad
    vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
  end, -- functions are always executed during startup

  config = function()
    -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
    vim.keymap.set("n", "zR", require("ufo").openAllFolds)
    vim.keymap.set("n", "zM", require("ufo").closeAllFolds)

    -- NOTE: use option 3 to avoid disabling semantic token
    -- Option 3: treesitter as a main provider instead
    -- Only depend on `nvim-treesitter/queries/filetype/folds.scm`,
    -- performance and stability are better than `foldmethod=nvim_treesitter#foldexpr()`
    require("ufo").setup({
      provider_selector = function(bufnr, filetype, buftype)
        return { "treesitter", "indent" }
      end,
    })
  end,
}
