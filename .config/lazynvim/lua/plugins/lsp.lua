return {
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    keys = { 
      { ";m", "<cmd>Mason<cr>" },
    },
    build = ":MasonUpdate",
    opts = {}
  },

  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      automatic_installation = true,
      ensure_installed = {
        "bashls",
        "clangd",
        "dockerls",
        "gopls",
        "lua_ls",
        "pyright",
        "ruff",
        "terraformls"
      }
    }
  },
}
