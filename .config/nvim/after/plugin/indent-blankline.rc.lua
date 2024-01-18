local status, ibl = pcall(require, "ibl")
if not status then
	vim.notify("Failed to load indent-blankline")
	return
end

ibl.setup({
	scope = {
		enabled = false,
	},
})
