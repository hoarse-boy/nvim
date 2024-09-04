local char_symbol = "▏"

return {
  "nvimdev/indentmini.nvim",
  enabled = false, -- disabled plugin -- FIX: got an error in yaml file. change to default lazyvim indent plugins.
  event = "LazyFile",
  config = function()
    -- Colors are applied automatically based on user-defined highlight groups.
    -- There is no default value.
    -- vim.cmd.highlight("IndentLine guifg=#323b4a")
    vim.cmd.highlight("IndentLine guifg=#4d4b49")
    -- Current indent line highlight
    vim.cmd.highlight("IndentLineCurrent guifg=#87b7c7")

    require("indentmini").setup({
      char = char_symbol,
    })
  end,
}
