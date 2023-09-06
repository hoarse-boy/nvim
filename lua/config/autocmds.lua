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

-- -- Open Telescope on startup if the first argument is a directory
-- local ts_group = vim.api.nvim_create_augroup("TelescopeOnEnter", { clear = true })
-- vim.api.nvim_create_autocmd({ "VimEnter" }, {
--   callback = function()
--     -- vim.cmd("Neotree")

--     local first_arg = vim.v.argv[3]
--     if first_arg and vim.fn.isdirectory(first_arg) == 1 then
--       -- Vim creates a buffer for folder. Close it.
--       vim.cmd(":bd 1")
--       require("telescope.builtin").find_files({ search_dirs = { first_arg } })
--     end
--   end,
--   group = ts_group,
-- })
