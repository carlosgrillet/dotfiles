local status, colorizer = pcall(require, "colorizer")
if not status then
	vim.notify("Failed to load colorizer")
	return
end

colorizer.setup({
	"*",
})
