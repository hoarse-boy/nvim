% My Help Topic
% Author Name
% Date

# My Help Topic

This is a description of my topic.

## Section 1

Details about section 1.

## Section 2

More details about section 2.

```lua
-- This is a lua code block
local a = 1
```

-- TODO: remove this and put it in a readme.md that can be called using kiwi.nvim?
-- NOTE: reminder / notes / other cool stuff of nvim or other plugin
-- +notes which-key
-- stylua: ignore
set("n", "<leader>?S",
  function()
    local notify = require("notify")
    notify("use ctrl j / i\nto jump to LuaSnip placeholder", "info", { title = "helper" })
  end, { desc = printf "Jump to previous placeholder (LuaSnip)", noremap = true, silent = true })

set("n", "<leader>?n", function()
  local notify = require("notify")
  notify("ctrl a / x to increase or decrement a number.\ncan also have prefix like 5 ctrl a.\ncan be dot repeated", "info", { title = "helper" })
end, { desc = printf("Increase / decrement number"), noremap = true, silent = true })

set("n", "<leader>?l", function()
  local notify = require("notify")
  notify(":pwd to show location", "info", { title = "helper" })
end, { desc = printf("pwd"), noremap = true, silent = true })

set("n", "<leader>?s", function()
  local notify = require("notify")
  notify("visual block the words, open cmdline, and type sort", "info", { title = "helper" })
end, { desc = printf("sort list (alphabetical or numerical)"), noremap = true, silent = true })

set("n", "<leader>?r", function()
  local notify = require("notify")
  notify("vim cmd search and replace.\n%s/search/replace/\n':%s/' start of the search pattern\n'/' end of the search pattern, beginning of replacement pattern\noptional = '/e' suppress error messages if no match found", "info", { title = "helper" })
end, { desc = printf("Vim Search Replace Cmd"), noremap = true, silent = true })

set("n", "<leader>?y", function()
  local notify = require("notify")
  notify("use 'yig' to yank the word under the cursor.", "info", { title = "helper" })
end, { desc = printf("mini.ai to yank entire buffer content"), noremap = true, silent = true })


for dap.
      -- TODO: change this to use vim txt?
      vim.keymap.set("n", "<leader>?d", function()
        local notify = require("notify")
        notify("<F5> to continue, <F7> to toggle breakpoint, <F8> to step over, <F9> to step into, <F10> to step out, <F12> to reset windows", "info", { title = "DAP helper" })
      end, { desc = printf("DAP helper"), noremap = true, silent = true })

vim:ft=help
