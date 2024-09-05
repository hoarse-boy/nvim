local M = {}

-- Define comment symbols for various filetypes
local filetype_formats = {
  javascript = "// %s",
  typescript = "// %s",
  java = "// %s",
  c = "// %s",
  go = "// %s",
  rust = "// %s",
  php = "// %s",
  cpp = "// %s",
  sh = "# %s",
  bash = "# %s",
  yaml = "# %s",
  perl = "# %s",
  ruby = "# %s",
  python = "# %s",
  mojo = "# %s",
  html = "<!-- %s -->",
  markdown = "<!-- %s -->",
  lua = "-- %s",
  css = "/* %s */",
}

-- define a local function to insert a todo comment keyword line and enter insert mode.
function M.insert_custom_todo_comments(keyword_str)
  if keyword_str == nil then
    keyword_str = "MARKED: " -- default.
  end

  -- Get the current buffer number
  local bufnr = vim.api.nvim_get_current_buf()
  -- Get the current line number
  local linenr = vim.api.nvim_win_get_cursor(0)[1]
  -- Get the file type of the current buffer using vim.bo
  local filetype = vim.bo[bufnr].filetype

  -- Get the comment symbol for the current filetype
  local comment_symbol = filetype_formats[filetype]

  -- Handle cases where the file type isn't in the list
  if comment_symbol == nil then
    print("Filetype " ..
    filetype ..
    " is not supported. manually add it to the comment_symbols in insert_custom_todo_comments.lua in util folder.")
    comment_symbol = "%s"
  end

  -- Format the commented string
  local fmt_keyword = string.format(comment_symbol, keyword_str)

  -- Check if the current line is empty before inserting the custom keyword line
  local current_line = vim.api.nvim_buf_get_lines(bufnr, linenr - 1, linenr, false)[1]
  if current_line == nil or current_line:match("^%s*$") then
    -- If current line is empty, insert the custom keyword line directly
    vim.api.nvim_buf_set_lines(bufnr, linenr - 1, linenr, false, { fmt_keyword })
  else
    -- If current line is not empty, insert the custom keyword line above and adjust current line position
    vim.api.nvim_buf_set_lines(bufnr, linenr - 1, linenr - 1, false, { fmt_keyword })
  end

  -- Move cursor to the end of the custom keyword line and enter insert mode
  vim.api.nvim_win_set_cursor(0, { linenr, #fmt_keyword })

  -- Enter insert mode
  vim.cmd("startinsert!")
end

-- TODO: add  bool in params, if true, go to insert mode by using vim 'A'.
-- define a local function to insert a todo comment keyword at the end of the current line.
function M.append_todo_comments_to_current_line(keyword_str, is_entering_insert_mode)
  if keyword_str == nil then
    keyword_str = "FIX: " -- default.
  end

  -- Get the current buffer number
  local bufnr = vim.api.nvim_get_current_buf()
  -- Get the current line number
  local linenr = vim.api.nvim_win_get_cursor(0)[1]
  -- Get the file type of the current buffer using vim.bo
  local filetype = vim.bo[bufnr].filetype

  -- Get the comment symbol for the current filetype
  local comment_symbol = filetype_formats[filetype]

  -- Handle cases where the file type isn't in the list
  if comment_symbol == nil then
    print("Filetype " ..
    filetype ..
    " is not supported. manually add it to the comment_symbols in insert_custom_todo_comments.lua in util folder.")
    comment_symbol = "%s"
  end

  -- Format the commented string
  local fmt_keyword = string.format(comment_symbol, keyword_str)

  -- Get the current line content
  local current_line = vim.api.nvim_buf_get_lines(bufnr, linenr - 1, linenr, false)[1]

  -- Append the custom keyword to the current line
  local new_line = current_line .. " " .. fmt_keyword

  -- Update the current line with the new content
  vim.api.nvim_buf_set_lines(bufnr, linenr - 1, linenr, false, { new_line })

  -- FIX: test
  if is_entering_insert_mode then
    -- Move cursor to the end of the custom keyword line and enter insert mode
    vim.api.nvim_win_set_cursor(0, { linenr, #fmt_keyword })

    -- Enter insert mode
    vim.cmd("startinsert!")
  end
end

return M
