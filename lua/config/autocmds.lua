-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- NOTE: configure the speed of yank
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- make yank animation to be blazingly fast
local yank_group = augroup("HighlightYank", {})
autocmd("TextYankPost", {
  group = yank_group,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 10, -- yank latency
    })
  end,
})

-- FIX:
-- -- unfold folded code when opening any files
-- local auto_fold = augroup("OpenFold", {})
-- autocmd("BufReadPost,FileReadPost", {
--   group = auto_fold,
--   pattern = "*",
--   callback = function()
--     api.nvim_command("normal zR")
--   end,
-- })

-- remove highlight to make it transparent
vim.cmd("highlight TelescopeBorder guibg=none")
vim.cmd("highlight TelescopeTitle guibg=none")
