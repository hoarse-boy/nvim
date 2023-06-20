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

-- remove highlight to make it transparent. can only be in autocmd? not working in option
-- TODO: move to theme?
-- -- FIX: DELETE LATER not working when launch nvim in other repo. if launched using v / 'nvim .' it will not have the guibg changed
-- vim.cmd("highlight FloatBorder guibg=none")
-- vim.cmd("highlight NormalFloat guibg=none")
-- vim.cmd("highlight TelescopeBorder guibg=none")
-- vim.cmd("highlight TelescopeTitle guibg=none")
-- vim.cmd("highlight TelescopeNormal guibg=none")
