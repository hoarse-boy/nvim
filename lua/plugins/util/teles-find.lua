-- vim.cmd('cd ~/google-drive/obsidian-vault/todos/')
local M = {}

function M.ChangeDirAndFindFiles(directory)
  -- Change the current working directory
  vim.cmd('cd ' .. directory)
  -- Call Telescope find_files
  require('telescope.builtin').find_files({ cwd = vim.fn.expand('%:p:h') })
end

return M
