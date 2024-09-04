local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
    lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },

    -- import any extras modules here from lazyvim.
    { import = "lazyvim.plugins.extras.lang.docker" },
    { import = "lazyvim.plugins.extras.lang.yaml" },
    { import = "lazyvim.plugins.extras.lang.typescript" },
    { import = "lazyvim.plugins.extras.lang.terraform" },
    { import = "lazyvim.plugins.extras.util.project" },
    { import = "lazyvim.plugins.extras.test.core" },
    { import = "lazyvim.plugins.extras.lsp.none-ls" },
    { import = "lazyvim.plugins.extras.lang.helm" },
    { import = "lazyvim.plugins.extras.lang.php" },
    { import = "lazyvim.plugins.extras.editor.telescope" },
    { import = "lazyvim.plugins.extras.lang.python" },
    { import = "lazyvim.plugins.extras.coding.mini-surround" },
    { import = "lazyvim.plugins.extras.coding.luasnip" },
    { import = "lazyvim.plugins.extras.dap.nlua" },
    { import = "lazyvim.plugins.extras.lang.json" },
    { import = "lazyvim.plugins.extras.util.mini-hipatterns" }, -- highlight patterns, including tailwind.
    -- { import = "lazyvim.plugins.extras.lang.rust" }, -- TODO: check this plugin, and if it better, add which key instead of making my own.
    -- { import = "lazyvim.plugins.extras.lsp.neoconf" }   ,
    -- { import = "lazyvim.plugins.extras.editor.inc-rename" }, -- NOTE: dont use this as the rename cannot use vim normal mode.
    -- { import = "lazyvim.plugins.extras.lang.markdown" }, -- disable as the none-ls warning is too many. TODO: change the warning parameters
    -- { import = "lazyvim.plugins.extras.dap.core" }, -- NOTE: dont import this, it makes the debugger to have double debugger option. lazyvim version 12.38.2
    -- { import = "lazyvim.plugins.extras.editor.aerial" }, -- rarely used.

    -- import all of my languages config.
    { import = "plugins.extras.lang.go" },
    { import = "plugins.extras.lang.markdown" }, -- NOTE: enable toc plugin for markdown
    { import = "plugins.extras.lang.rust" },
    { import = "plugins.extras.lang.helm" },
    -- { import = "plugins.extras.lang.json" },
    -- { import = "plugins.extras.lang.php" }, -- NOTE: causing lspconfig to load at startup, causing performance issue (50ms delay).

    -- import all of my coding plugins.
    { import = "plugins.extras.coding.supermaven" }, --supermaven is a better codeium alternative.

    -- import dap plugins
    { import = "plugins.extras.dap.dap" },

    -- import/override with your plugins
    { import = "plugins" },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = {
    -- install missing plugins on startup. This doesn't increase startup time.
    missing = false,
    -- colorscheme = { "tokyonight", "habamax" }
  },
  -- ui config
  ui = {
    border = "single",
    size = {
      width = 0.8,
      height = 0.8,
    },
  },
  checker = { enabled = true, notify = false }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        "netrwPlugin", -- NOTE: disable this as it is visually buggy when opening nvim with 'nvim .'
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
