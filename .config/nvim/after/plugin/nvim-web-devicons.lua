local status, icons = pcall(require, "nvim-web-devicons")
if not status then
	vim.notify("Failed to load nvim-web-devicons")
	return
end

icons.setup({
	override = {},
	default = true,
})
