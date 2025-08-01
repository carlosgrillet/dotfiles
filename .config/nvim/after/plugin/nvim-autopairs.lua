local status, autopairs = pcall(require, "nvim-autopairs")
if not status then
	vim.notify("Failed to load nvim-autopairs")
	return
end

autopairs.setup({
	disable_filetype = { "TelescopePrompt", "vim" },
})
