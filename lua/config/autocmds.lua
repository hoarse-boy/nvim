-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

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

local auto_start_lsp_group = augroup("AutoStartLsp", {})
-- " autocmd("BufRead", {
autocmd("UIenter", {
  -- autocmd("WinScrolled", {
  -- autocmd("BufEnter", {
  -- autocmd("FileType", {
  -- autocmd("CmdlineLeave", {
  group = auto_start_lsp_group,
  pattern = "*",
  once = true,
  callback = function()
    print("kabom")
    local ft = vim.bo.filetype
    if ft == "neo-tree" then
      -- vim.cmd([[silent! Neotree go.mod | edit go.mod]])
      -- vim.cmd([[silent! find go.mod]])
      print("kabom2")
    end
  end,
})
