-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- NOTE: put the delete keymaps from the default lazymap keymaps here before overwrite it
-- this is especially usefull if the keymaps will be overwrite by a prefix
local del = vim.keymap.del
del("n", "<leader>l")
del("n", "<leader>xl")
del("n", "<leader>xq")

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

local opt = { noremap = true, silent = true }

map("i", "jk", "<esc>l", opt) -- added l when escaped to normal mode as to not make the cursor move back 1 line

-- save global path to "p" and save to clipboard
map(
  "n",
  "cp",
  'o<esc>:let @" = expand("%:p")<cr>""pVxk',
  { noremap = true, silent = true, desc = "Copy path to register" }
) -- added l when escaped to normal mode as to not make the cursor move back 1 line
-- map("n", "cp", ':let @" = expand("%:p")<cr>""', { noremap = true, silent = true, desc = "Copy path to register" }) -- added l when escaped to normal mode as to not make the cursor move back 1 line

-- NOTE: it should be "_d so uses '' to make the string, else the keymap will not be working
-- "_* will not save to clipboard.
map("n", "d", '"_d', opt)
map("v", "d", '"_d', opt) -- lazyvim dont have x in visual mode, but now it has.
map("n", "dd", '"_dd', opt)

map("n", "D", '"_D', opt)
map("n", "x", '"_x', opt)

map("n", "c", '"_c', opt)
map("v", "c", '"_c', opt)
map("n", "C", '"_C', opt)
map("v", "C", '"_C', opt)

-- git which-key
map("n", "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<cr>", { desc = "Toggle Git Blame (virtual text)" })

map("n", "<leader>sx", require("telescope.builtin").resume, { noremap = true, silent = true, desc = "Resume" })

-- lazy
map("n", "<leader>L", "<cmd>:Lazy<cr>", { desc = "Lazy" }) -- use L instead of l

-- other keymaps
map("n", "<leader>st", "<cmd>TodoTelescope<CR>", { desc = "Todo Telescope" })
map("n", "<leader>cc", "<cmd>lua require('treesitter-context').go_to_context()<cr>", { desc = "Go to Context" }) -- cannot create this keymap in the plugin folder as it will disable the ts-context plugin by lazyload it

-- comments (why uses <Plug> = to avoid go to normal mode)
map("v", "<leader>/", "<Plug>(comment_toggle_linewise_visual)", { desc = "Comment toggle linewise (visual)" })
map("n", "<leader>/", "<Plug>(comment_toggle_linewise_current)", { desc = "Comment toggle current line" })
