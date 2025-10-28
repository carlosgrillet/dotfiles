local status, nvim_lsp = pcall(require, "lspconfig")
if not status then
	vim.notify("Failed to load lspconfig")
	return
end

local protocol = require("vim.lsp.protocol")

local on_attach = function(client, bufnr)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "LSP Jump to definition" })
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = "LSP See references" })
  vim.keymap.set('n', 'gR', vim.lsp.buf.rename, { desc = "LSP Rename" })
  vim.keymap.set('n', 'gi', vim.lsp.buf.hover, { desc = "LSP Hover" })
  vim.keymap.set('n', '<leader>d', function()
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
  end, { silent = true, noremap = true })
end

protocol.CompletionItemKind = {
	"󰉿", -- Text
	"󰆧", -- Method
	"󰊕", -- Function
	"", -- Constructor
	"󰜢", -- Field
	"", -- Variable
	"", -- Class
	"", -- Module
	"", -- Property
	"", -- Unit
	"󰎠", -- Value
	"", -- Enum
	"󰌋", -- Keyword
	"", -- Snippet
	"", -- Color
	"", -- File
	"󰈇", -- Reference
	"", -- Folder
	"", -- EnumMember
	"", -- Constant
	"󰙅", -- Struct
	"", -- Event
	"", -- TypeParameter
}

-- Set up completion using nvim_cmp with LSP source
local capabilities = require("cmp_nvim_lsp").default_capabilities()

nvim_lsp.lua_ls.setup({
	-- on Windows run:  scoop install lua-language-server
	on_attach = on_attach,
	capabilities = capabilities,
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if path ~= vim.fn.stdpath('config') and (vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc')) then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force',
      client.config.settings.Lua, {
        runtime = { version = 'LuaJIT' },
        workspace = { checkThirdParty = false, library = { vim.env.VIMRUNTIME }
      }
    })
  end,
  settings = {
    Lua = {}
  }
})

nvim_lsp.ruff.setup {
  init_options = {
    settings = {
      lineLength = 79,
      lint = {
        ignore = {"E4", "E7"}
      }
    }
  }
}

nvim_lsp.dockerls.setup({
	-- on windows run: npm install -g dockerfile-language-server-nodejs
	on_attach = on_attach,
	capabilities = capabilities,
})

nvim_lsp.bashls.setup({
	-- npm install -g bash-language-server
	on_attach = on_attach,
	capabilities = capabilities,
})

nvim_lsp.gopls.setup {
  -- go install golang.org/x/tools/gopls@latest
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {"gopls"},
  filetypes = {"go", "gomod", "gowork", "gotmpl"},
  root_dir = nvim_lsp.util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      gofumpt = true,
      analyses = {
        unusedparams = true,
        unusedvariables = true,
      },
    },
  },
}

nvim_lsp.rust_analyzer.setup({
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = { command = "clippy" },
      cargo = { loadOutDirsFromCheck = true },
      procMacro = { enable = true },
    },
  },
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, {
    border = "rounded",
    title = "hover"
  }
)
-- Diagnostic symbols in the sign column (gutter)
local signs = { Error = "x ", Warn = " ", Hint = "! ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.diagnostic.config({
	virtual_text = {
		prefix = "●",
	},
	update_in_insert = true,
	float = {
		source = true, -- Or "if_many"
	},
})
