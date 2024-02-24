-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

augroup("mygroup", { clear = true })

-- NOTE: disable this in favor of the yanky plugin
-- -- make yank animation to be blazingly fast
-- local yank_group = augroup("HighlightYank", {})
-- autocmd("TextYankPost", {
--   group = yank_group,
--   pattern = "*",
--   callback = function()
--     vim.highlight.on_yank({
--       higroup = "IncSearch",
--       timeout = 10, -- yank latency
--     })
--   end,
-- })

autocmd("Filetype", {
  pattern = { "*" },
  callback = function()
    -- vim.opt.formatoptions = vim.opt.formatoptions - "o"
    if vim.bo["ft"] == "css" then
      vim.opt_local.formatoptions:remove("r") -- don't enter comment leader on Enter in css files
    end
    vim.opt.formatoptions = vim.opt.formatoptions
      + {
        o = false, -- Don't continue comments with o and O
        r = false, -- don't insert comment leader on Enter
      }
  end,
  group = "mygroup",
  desc = "Don't continue comments with o and O",
})
