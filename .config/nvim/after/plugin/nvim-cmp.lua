local status, cmp = pcall(require, "cmp")
if not status then
	vim.notify("Failed to load cmp")
	return
end

local compare = require("cmp.config.compare")
local lspkind = require("lspkind")
local luasnip = require("luasnip")

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
	}, {
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
      winhighlight = 'Normal:TelescopePromptNormal,FloatBorder:TelescopePromptBorder,CursorLine:PmenuSel,Search:None',
    },
    documentation = {
      border = "rounded",
      winhighlight = 'FloatBorder:TelescopePromptBorder',
    }
  }
})
