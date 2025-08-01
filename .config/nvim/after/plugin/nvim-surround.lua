local status, surround = pcall(require, "nvim-surround")
if not status then
	vim.notify("Failed to load nvim-surround")
	return
end

surround.setup({})
