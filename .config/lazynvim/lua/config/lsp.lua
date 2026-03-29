local on_attach = function(_, _)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "LSP Jump to definition" })
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = "LSP See references" })
  vim.keymap.set('n', 'gR', vim.lsp.buf.rename, { desc = "LSP Rename" })
  vim.keymap.set('n', 'gi', vim.lsp.buf.hover, { desc = "LSP Hover" })
  vim.keymap.set('n', 'gI', vim.diagnostic.open_float, { desc = "Show diagnostics" })
  vim.keymap.set('n', '<leader>ff', vim.lsp.buf.format, { desc = "LSP Format" })
  vim.keymap.set('n', '<leader>d', function()
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
  end, { silent = true, noremap = true })
end

vim.lsp.config("lua_ls", {
  -- on Windows run:  scoop install lua-language-server
  on_attach = on_attach,
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
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
vim.lsp.enable("lua_ls")

vim.lsp.config("gopls", {
  -- go install golang.org/x/tools/gopls@latest
  on_attach = on_attach,
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
vim.lsp.enable("gopls")

vim.lsp.enable("ruff")

vim.lsp.enable("dockerls")

vim.lsp.enable("bashls")

vim.lsp.config("pyright", {
  on_attach = on_attach,
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
vim.lsp.enable("pyright")

vim.lsp.config("rust_analyzer", {
  on_attach = on_attach,
  filetypes = { "rust" },
  root_dir = vim.lsp.client.root_dir,
  cmd = { "rust-analyzer" },
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
        loadOutDirsFromCheck = true,
      },
      checkOnSave = {
        command = "clippy",
        extraArgs = { "--no-deps" },
        allFeatures = true,
      },
      procMacro = {
        enable = true,
      },
      inlayHints = {
        bindingModeHints = { enable = true },
        chainingHints = { enable = true },
        closingBraceHints = { enable = true, minLines = 25 },
        closureReturnTypeHints = { enable = "always" },
        expressionAdjustmentHints = { enable = "always" },
        lifetimeElisionHints = { enable = "always", useParameterNames = true, },
        parameterHints = { enable = true },
        typeHints = { enable = true },
      },
      diagnostics = {
        enable = true,
        style = "ide",
        experimental = { enable = true },
      },
      imports = {
        granularity = { group = "module" },
        prefix = "self",
      },
    },
  }
})
vim.lsp.enable("rust_analyzer")

vim.lsp.config("clangd", {
  on_attach = on_attach,
  filetypes = { "c", "cpp" },
  cmd = {
    "clangd",
    "--background-index",
    "--suggest-missing-includes",
    "--all-scopes-completion",
    "--completion-style=detailed",
  }
})
vim.lsp.enable("clangd")

vim.lsp.config("asm_lsp", {
  on_attach = on_attach,
  filetypes = { "asm" },
  cmd = { "asm-lsp" },
})
vim.lsp.enable("asm_lsp")


vim.lsp.config("terraformls", {
  on_attach = on_attach,
  filetypes = { "terraform", "tf", "hcl", "tfvars" },
  cmd = { "terraform-ls", "serve" }
})
vim.lsp.enable("clangd")

-- Diagnostic symbols in the sign column (gutter)
local signs = {
  [vim.diagnostic.severity.ERROR] = { icon = " ", hl = "Error" },
  [vim.diagnostic.severity.WARN]  = { icon = " ", hl = "Warn" },
  [vim.diagnostic.severity.INFO]  = { icon = " ", hl = "Info" },
  [vim.diagnostic.severity.HINT]  = { icon = "󰋗 ", hl = "Hint" },
}

local text = {}

for severity, config in pairs(signs) do
  text[severity] = config.icon
end

vim.diagnostic.config({
  signs = {
    text = text,
  },
  -- virtual_text = { -- disabled for now, too much text on the screen
  --   prefix = "●",
  -- },
  update_in_insert = true,
  float = {
    border = "rounded",
    source = true, -- Or "if_many"
    max_width = 78,
  },
})
