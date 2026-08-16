return {
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      {
        "mason-org/mason.nvim",
        keys = {
          { ";m", "<cmd>Mason<cr>" },
        },
        build = ":MasonUpdate",
        opts = {},
      },
      "neovim/nvim-lspconfig",
    },
    opts = {
      automatic_enable = false,
      ensure_installed = {
        "bashls",
        "clangd",
        "dockerls",
        "gopls",
        "lua_ls",
        "pyright",
        "ruff",
        "terraformls",
      }
    }
  },
}
