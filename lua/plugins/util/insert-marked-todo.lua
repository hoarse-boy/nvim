local M = {}

-- Define a local function to insert a commented MARKED line and enter insert mode
function M.insert_marked_line()
  -- Get the current buffer number
  local bufnr = vim.api.nvim_get_current_buf()
  -- Get the current line number
  local linenr = vim.api.nvim_win_get_cursor(0)[1]
  -- Get the file type of the current buffer using vim.bo
  local filetype = vim.bo[bufnr].filetype

  -- Define comment symbols for various filetypes
  local comment_symbols = {
    javascript = "//",
    typescript = "//",
    java = "//",
    c = "//",
    go = "//",
    rust = "//",
    php = "//",
    cpp = "//",
    lua = "--",
    html = "<!-- -->",
    markdown = "<!-- -->",
    css = "/* */",
    sh = "#",
    bash = "#",
    perl = "#",
    ruby = "#",
    python = "#",
    mojo = "#",
  }

  -- Get the comment symbol for the current filetype
  local comment_symbol = comment_symbols[filetype]

  -- Handle cases where the file type isn't in the list
  local marked_line
  if comment_symbol == nil then
    print("Filetype " ..
    filetype .. " is not supported. Manually add it to the comment_symbols in insert-marked-todo.lua in util folder.")
    marked_line = "MARKED: "
  else
    -- Format the commented MARKED line
    if comment_symbol == "<!-- -->" then
      marked_line = "<!-- MARKED: -->"
    elseif comment_symbol == "/* */" then
      marked_line = "/* MARKED: */"
    else
      marked_line = comment_symbol .. " MARKED: "
    end
  end

  -- Check if the current line is empty before inserting the MARKED line
  local current_line = vim.api.nvim_buf_get_lines(bufnr, linenr - 1, linenr, false)[1]
  if current_line == nil or current_line:match("^%s*$") then
    -- If current line is empty, insert the MARKED line directly
    vim.api.nvim_buf_set_lines(bufnr, linenr - 1, linenr, false, { marked_line })
  else
    -- If current line is not empty, insert the MARKED line above and adjust current line position
    vim.api.nvim_buf_set_lines(bufnr, linenr - 1, linenr - 1, false, { marked_line })
    -- Move cursor to the end of the MARKED line and enter insert mode
    vim.api.nvim_win_set_cursor(0, { linenr, #marked_line })
  end

  -- Move cursor to the end of the MARKED line and enter insert mode
  vim.api.nvim_win_set_cursor(0, { linenr, #marked_line })

  -- Enter insert mode
  vim.cmd("startinsert!")
end

return M
