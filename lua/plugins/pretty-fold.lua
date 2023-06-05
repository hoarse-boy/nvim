return {
  "anuvyklack/pretty-fold.nvim",
  event = "VeryLazy",
  config = function()
    -- autcmd
    -- FIX: move to
    -- TODO: move to pretty fold
    -- -- unfold folded code when opening any files
    -- local auto_fold = augroup("OpenFold", {})
    -- autocmd("BufReadPost,FileReadPost", {
    --   group = auto_fold,
    --   pattern = "*",
    --   callback = function()
    --     api.nvim_command("normal zR")
    --   end,
    -- })

    -- NOTE: fold
    -- opt.foldmethod = "expr"
    -- opt.foldexpr = "nvim_treesitter#foldexpr()"

    require("pretty-fold").setup({
      keep_indentation = false,
      fill_char = "━",
      sections = {
        left = {
          "━ ",
          function()
            return string.rep("*", vim.v.foldlevel)
          end,
          " ━┫",
          "content",
          "┣",
        },
        right = {
          "┫ ",
          "number_of_folded_lines",
          ": ",
          "percentage",
          " ┣━━",
        },
      },
    })
  end,
}
