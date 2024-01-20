local status, prettier = pcall(require, "prettier")
if not status then
	vim.notify("Failed to load prettier")
	return
end

prettier.setup({
	bin = "prettierd",
	filetypes = {
		"python",
		"lua",
		"css",
		"javascript",
		"javascriptreact",
		"json",
		"yaml",
	},
})
