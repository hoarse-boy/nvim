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

-- local test = augroup("AutoStartLsp", {})
-- autocmd("Filetype", {
--   group = test,
--   pattern = "*",
--   callback = function()
--     print("kabomkj:")
--     local ok, lspList = pcall(require, "plugins.extras.lang")
--     if ok then
--       for key, value in pairs(lspList[1]) do
--         local findFile = vim.fn.findfile(value, ".;")
--         if findFile == value then
--           local vimCmd = string.format("LspStart %s", key)
--           vim.cmd(vimCmd)
--           break
--         end
--       end
--     end
--   end,
-- })

-- vim.api.nvim_create_autocmd("BufReadPost", {
-- vim.api.nvim_create_autocmd("BufReadPost", {

-- NOTE: this cause golang to behave strangely
-- local autoStartLsp = augroup("MyAutoStartLsp", { clear = true })
-- vim.api.nvim_create_autocmd("BufEnter", {
--   -- desc = 'format python on write using black', -- FIX:

--   group = autoStartLsp,
--   callback = function(opts)
--     -- print("ini buf", opts.buf)
--     print(vim.bo[opts.buf].filetype)
--     if vim.bo[opts.buf].filetype == "alpha" then
--       -- print("kabom")
--       -- vim.cmd 'Black'

--       local ok, lspList = pcall(require, "plugins.extras.lang")
--       if ok then
--         for key, value in pairs(lspList[1]) do
--           local findFile = vim.fn.findfile(value, ".;")
--           if findFile == value then
--             local vimCmd = string.format("LspStart %s", key)
--             vim.cmd(vimCmd)
--             break
--           end
--         end
--       end

--       vim.api.nvim_del_augroup_by_id(autoStartLsp) -- to make it run once

--       -- -- FIX: and then delete the autocmd. to make it never run again
--     end
--   end,
-- })
