local status, mason = pcall(require, "mason")
if not status then
	vim.notify("Failed to load mason")
	return
end
local status2, lspconfig = pcall(require, "mason-lspconfig")
if not status2 then
	vim.notify("Failed to load mason-lspconfig")
	return
end

mason.setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

lspconfig.setup({
	ensure_installed = {
		"bashls",   -- bash
		"dockerls", -- Dockerfile
		"lua_ls",   -- lua
		"pylsp",    -- pyhton
    "gopls",    -- go
	},
	automatic_installation = true,
})

vim.keymap.set("n", ";m", ":Mason<Return>", {silent = true})
