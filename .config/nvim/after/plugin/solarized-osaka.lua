local status, solarized_osaka = pcall(require, "solarized-osaka")
if not status then
	vim.notify("Failed to load solarized-osaka")
	return
end

solarized_osaka.setup({
	transparent = true,
	styles = {
		sidebars = "transparent",
		floats = "transparent",
	},
})

vim.cmd([[colorscheme solarized-osaka]])
