-- put all other plugins that do not need any major code setup

return {
  { "theprimeagen/harpoon", event = "VeryLazy" },
  -- { "nvim-treesitter/nvim-treesitter-context" }, -- cannot use the plugin when it uses event = "VeryLazy"
}
