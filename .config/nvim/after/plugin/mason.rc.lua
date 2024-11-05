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
		"dockerls", -- Dockerfile
		"eslint", -- javascript
		"lua_ls", -- lua
		"pylsp", -- pyhton
		"ts_ls", -- typescript
		"bashls", -- bash
	},
	automatic_installation = true,
})
