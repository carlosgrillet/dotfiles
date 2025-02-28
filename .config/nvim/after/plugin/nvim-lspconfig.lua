local status, nvim_lsp = pcall(require, "lspconfig")
if not status then
	vim.notify("Failed to load lspconfig")
	return
end

local protocol = require("vim.lsp.protocol")

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end

	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	--Enable completion triggered by <c-x><c-o>
	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	local opts = { noremap = true, silent = true }

  vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references)
  vim.keymap.set('n', 'gR', vim.lsp.buf.rename)
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
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

nvim_lsp.lua_ls.setup({
	-- on Windows run:  scoop install lua-language-server
	on_attach = on_attach,
	capabilities = capabilities,
})

nvim_lsp.dockerls.setup({
	-- on windows run: npm install -g dockerfile-language-server-nodejs
	on_attach = on_attach,
	capabilities = capabilities,
})

nvim_lsp.pylsp.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		pylsp = {
			plugins = {
				pycodestyle = {
					maxLineLength = 100,
				},
			},
		},
	},
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

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	underline = true,
	update_in_insert = false,
	virtual_text = { spacing = 4, prefix = "●" },
	severity_sort = true,
})

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
		source = "always", -- Or "if_many"
	},
})
