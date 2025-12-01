-- local status, nvim_lsp = pcall(require, "lspconfig")
-- if not status then
-- 	vim.notify("Failed to load lspconfig")
-- 	return
-- end

local protocol = require("vim.lsp.protocol")

local on_attach = function(client, bufnr)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "LSP Jump to definition" })
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = "LSP See references" })
  vim.keymap.set('n', 'gR', vim.lsp.buf.rename, { desc = "LSP Rename" })
  vim.keymap.set('n', 'gi', vim.lsp.buf.hover, { desc = "LSP Hover" })
  vim.keymap.set('n', '<leader>ff', vim.lsp.buf.format, { desc = "LSP Format" })
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

vim.lsp.config('lua_ls', {
  -- on Windows run:  scoop install lua-language-server
  on_attach = on_attach,
  capabilities = capabilities,
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if path ~= vim.fn.stdpath('config') and (vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc')) then
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

vim.lsp.config('pyright', {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "python" },
  settings = {
    pyright = {
      disableOrganizeImports = true,
    },
    python = {
      analysis = {
        ignore = { "*" },
      },
    },
  }
})

vim.lsp.config('ruff', {
  on_attach = on_attach,
  capabilities = capabilities,
})

vim.lsp.config('dockerls', {
  -- on windows run: npm install -g dockerfile-language-server-nodejs
  on_attach = on_attach,
  capabilities = capabilities,
})

vim.lsp.config('bashls', {
  -- npm install -g bash-language-server
  on_attach = on_attach,
  capabilities = capabilities,
})

vim.lsp.config('gopls', {
  -- go install golang.org/x/tools/gopls@latest
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = vim.lsp.client.root_dir,
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
})

vim.lsp.config('rust_analyzer', {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = { command = "clippy" },
      cargo = { loadOutDirsFromCheck = true },
      procMacro = { enable = true },
    },
  },
})

vim.lsp.config('clangd', {
  on_attach = on_attach,
  capabilities = capabilities,
})

vim.lsp.config('terraformls', {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { 'terraform', 'tf', 'hcl', 'tfvars'},
  cmd = {'terraform-ls', 'serve'}
})

vim.lsp.config('tflint', {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { 'terraform', 'tf', 'hcl', 'tfvars'},
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
    source = true, -- Or "if_many"
  },
})
