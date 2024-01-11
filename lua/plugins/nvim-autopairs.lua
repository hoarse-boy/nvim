return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },

  -- NOTE: mini pairs has wierd behaviour when that adds unnessaccry pairs where it should not. it also failed when adding ``` as it will add ```` this many and need to manualy deleted.
  {
    "echasnovski/mini.pairs",
    enabled = false,
  },
}
