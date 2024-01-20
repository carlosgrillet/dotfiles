local status, nli = pcall(require, "nvim-lsp-installer")
if not status then
	vim.notify("Failed to load nvim-lsp-installer")
	return
end

nli.setup({
	automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
	ui = {
		icons = {
			server_installed = "✓",
			server_pending = "➜",
			server_uninstalled = "✗",
		},
	},
})
