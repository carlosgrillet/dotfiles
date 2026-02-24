return {
  {
    "hrsh7th/nvim-cmp",
    config = function()
      local compare = require("cmp.config.compare")
      local lspkind = require("lspkind")
      local luasnip = require("luasnip")
      local cmp = require("cmp")

      cmp.setup({
        preselect = false,
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = {
          completeopt = 'menu,menuone,noselect',
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.close(),
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
        }),
        formatting = {
          format = lspkind.cmp_format({ with_text = false, maxwidth = 50 }),
        },
        sorting = {
          comparators = {
            compare.offset,
            compare.exact,
            compare.score,
            compare.sort_text,
            compare.kind,
            compare.length,
            compare.order,
          },
        },
        window = {
          completion = {
            border = "rounded",
            winhighlight = 'Normal:CmpNormal,FloatBorder:NonText,CursorLine:TermCursor,Search:None',
          },
          documentation = {
            border = "rounded",
            winhighlight = 'FloatBorder:NonText',
          }
        }
      })
    end,
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "onsails/lspkind-nvim",
    }
  },

  {
    "windwp/nvim-autopairs",
    opts = {},
    config = function(_, opts)
      require("nvim-autopairs").setup(opts)
    end,
  },

  {
    "kylechui/nvim-surround",
    opts = {},
    config = function(_, opts)
      require("nvim-surround").setup(opts)
    end,
  },

  {
    "kyazdani42/nvim-web-devicons",
    opts = {
      override = {},
      default = true,
    },
    config = function(_, opts)
      require("nvim-web-devicons").setup(opts)
    end,
  },

  {
   "mfussenegger/nvim-lint",
    config = function()
      lint = require("lint")

      lint.linters_by_ft = {
        go = { "golangci-lint" },
      }
    end,
  },
  
  {
    "windwp/nvim-ts-autotag",
    opts = {},
    config = function(_, opts)
      require("nvim-ts-autotag").setup(opts)
    end,
  },

}
