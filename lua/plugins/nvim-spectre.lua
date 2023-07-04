return {
  "nvim-pack/nvim-spectre",
  keys = {
    {
      "<leader>sf",
      '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
      desc = "Search on current file",
    },
  },
}
