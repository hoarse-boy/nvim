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

-- lsp. the other keymaps are define in plugin lspconfig

-- dap
map("n", "<leader>ds", "<cmd>lua require'dap'.continue()<cr>", { desc = "Start Debugger" })
map("n", "<leader>dR", "<cmd>lua require'dap'.run_to_cursor()<cr>", { desc = "Run to Cursor" })
map("n", "<leader>dE", "<cmd>lua require'dapui'.eval(vim.fn.input '[Expression] > ')<cr>", { desc = "Evaluate Input" })
map(
  "n",
  "<leader>dC",
  "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>",
  { desc = "Conditional Breakpoint" }
)
map("n", "<leader>dU", "<cmd>lua require'dapui'.toggle()<cr>", { desc = "Toggle UI" })
map("n", "<leader>db", "<cmd>lua require'dap'.step_back()<cr>", { desc = "Step Back" })
map("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", { desc = "Continue" })
map("n", "<leader>dd", "<cmd>lua require'dap'.disconnect()<cr>", { desc = "Disconnect" })
map("n", "<leader>de", "<cmd>lua require'dapui'.eval()<cr>", { desc = "Evaluate" })
map("n", "<leader>dg", "<cmd>lua require'dap'.session()<cr>", { desc = "Get Session" })
-- map("n", "<leader>dh", "<cmd>lua require'dap.ui.widgets'.hover()<cr>", { desc = "Hover Variables" }) -- cannot exit using "q". find out more
map("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", { desc = "Step Into" })
map("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", { desc = "Step Over" })
map("n", "<leader>dp", "<cmd>lua require'dap'.pause.toggle()<cr>", { desc = "Pause" })
map("n", "<leader>dq", "<cmd>lua require'dap'.close()<cr>", { desc = "Quit" })
map("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", { desc = "Toggle Repl" })
map("n", "<leader>dt", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", { desc = "Toggle" })
map("n", "<leader>dx", "<cmd>lua require'dap'.terminate()<cr>", { desc = "Terminate" })
map("n", "<leader>du", "<cmd>lua require'dap'.step_out()<cr>", { desc = "Step Out" })

-- git which-key
map("n", "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<cr>", { desc = "Toggle Git Blame (virtual text)" })

-- map("n", "<leader>dS", "<cmd>lua require'dap.ui.widgets'.scopes()<cr>", { desc = "Scopes" })
-- open float_element of scopes
map(
  "n",
  "<leader>dS",
  '<cmd>lua require("dapui").float_element("scopes", { width = 90, height = 100, enter = true, position = "center" })<cr>',
  { desc = "Toggle Floating Scopes" }
)
-- open other float_element
map(
  "n",
  "<leader>dO",
  '<cmd>lua require("dapui").float_element(nil, { width = 90, height = 100, enter = true, position = "center" })<cr>',
  { desc = "Toggle Other Floating Element" }
)

map("n", "<leader>sx", require("telescope.builtin").resume, { noremap = true, silent = true, desc = "Resume" })

-- go-nvim
map("n", "<leader>lgs", "<cmd>GoFillStruct<cr>", { desc = "Go Fill Struct" })
map("n", "<leader>lgf", "<cmd>GoFillSwitch<cr>", { desc = "Go Fill Switch" })
map("n", "<leader>lgt", "<cmd>GoAddTag<cr>", { desc = "Go Add Tags" })
map("n", "<leader>lgr", "<cmd>GoRmTag<cr>", { desc = "Go Remove Tags" })
map("n", "<leader>lgT", "<cmd>GoTestFun<cr>", { desc = "Go Test a Function" })
map("n", "<leader>lgA", "<cmd>GoTestPkg<cr>", { desc = "Go Test Package" })
map("n", "<leader>lge", "<cmd>GoIfErr<cr>", { desc = "Go Auto Generate 'if err'" })
map("n", "<leader>lgc", "<cmd>GoCmt<cr>", { desc = "Go Generate Func Comments" })
map("n", "<leader>lgm", "<cmd>Gomvp<cr>", { desc = "Go Rename Module name" })
map("n", "<leader>lgm", "<cmd>GoFixPlurals<cr>", { desc = "Go Fix Redundant Func Params" }) -- not working?

-- lazy
map("n", "<leader>L", "<cmd>:Lazy<cr>", { desc = "Lazy" })

-- harpoon
map("n", "<leader>hm", "<cmd>lua require('harpoon.mark').add_file()<cr>", { desc = "Mark for Harpoon" })
map("n", "<leader>ht", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", { desc = "Toggle Quick Menu" })
map("n", "<leader>hn", "<cmd>lua require('harpoon.ui').nav_next()<cr>", { desc = "Go to next" })
map("n", "<leader>hp", "<cmd>lua require('harpoon.ui').nav_prev()<cr>", { desc = "Go to previous" }) -- FIX: not working?

-- other keymaps
map("n", "<leader>H", "<cmd>nohlsearch<CR>", { desc = "No Highlight" })
map("n", "<leader>st", "<cmd>TodoTelescope<CR>", { desc = "Todo Telescope" })

-- comments (why uses <Plug> = to avoid go to normal mode)
map("v", "<leader>/", "<Plug>(comment_toggle_linewise_visual)", { desc = "Comment toggle linewise (visual)" })
map("n", "<leader>/", "<Plug>(comment_toggle_linewise_current)", { desc = "Comment toggle current line" })
