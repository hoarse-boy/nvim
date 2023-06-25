return {
  {
    "towolf/vim-helm",
    event = { "CmdlineEnter" },
    ft = { "yaml" }, -- vim syntax for helm templates (yaml + gotmpl + sprig + custom)
  },

  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "helm-ls" })
      end
    end,
  },
}
