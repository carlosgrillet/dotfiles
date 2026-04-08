return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup({
        ensure_installed = {
          "asm",
          "bash",
          "c",
          "cmake",
          "diff",
          "go",
          "hcl",
          "html",
          "json",
          "lua",
          "python",
          "regex",
          "rust",
          "terraform",
          "vimdoc",
          "yaml",
        },
      })

      -- Enable treesitter highlighting for languages without built-in support
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })

      -- Textobjects (requires nvim-treesitter-textobjects on main branch)
      local ts_ok, textobjects = pcall(require, "nvim-treesitter-textobjects")
      if ts_ok then
        textobjects.setup({
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["if"] = "@function.inner",
              ["af"] = "@function.outer",
              ["io"] = "@class.inner",
              ["ao"] = "@class.outer",
              ["il"] = "@loop.inner",
              ["al"] = "@loop.outer",
              ["ic"] = "@conditional.inner",
              ["ac"] = "@conditional.outer",
              ["ib"] = "@block.inner",
              ["ab"] = "@block.outer",
            },
          },
        })
      end
    end,
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" },
    },
  }
}
