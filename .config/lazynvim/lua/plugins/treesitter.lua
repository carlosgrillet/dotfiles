return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    opts = {
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
        disable = {},
      },
      ensure_installed = {
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
        "terraform",
        "vimdoc",
        "yaml",
      },
      autotag = {
        enable = true,
      },
      textobjects = {
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
      }
    },
    config = function(_, opts)
      local TS = require("nvim-treesitter.configs")
      -- vim.api.nvim_create_autocmd("FileType", {
      --   pattern = opts.ensure_installed,
      --   callback = function() vim.treesitter.start() end,
      -- })
      TS.setup(opts)
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      branch = "master"
    },
  }
}
