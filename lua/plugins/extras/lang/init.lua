-- will be required in neo-tree to loop the file to auto start lsp
local M = {
  -- gopls = { "go.mod" },
  -- -- gopls = { "go.mod", "go.work", "main.go" },
  -- ["rust_analyzer"] = { "Cargo.toml" },
  {
    gopls = "go.mod",
    ["rust_analyzer"] = "Cargo.toml",
  },
}

return M
