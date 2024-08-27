return {
  -- TODO: remove? this is kinda buggy.
  -- when typing in telescope and when using flash.nvim
  {
    "joshuadanpeterson/typewriter",
    event = "VeryLazy",
    enabled = false, -- FIX: 
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("typewriter").setup()
      vim.cmd([[TWEnable]])

      -- fix
      
      -- local autocmd = vim.api.nvim_create_autocmd
      -- local augroup = vim.api.nvim_create_augroup

      -- augroup("mygroup", { clear = true })

      -- -- create autocmd to start typewriter on file open
      -- autocmd("BufEnter", {
      --   pattern = "*",
      --   callback = function()
      --     -- require("typewriter").enable_typewriter_mode()

      --     vim.cmd([[TWEnable]])
      --   end,
      --   group = "mygroup",
      --   desc = "Start typewriter on file open",
      -- })

    end,
  },
}
