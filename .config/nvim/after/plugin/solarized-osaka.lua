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
	sidebars = { "qf", "help" },
	day_brightness = 0.3,
	hide_inactive_statusline = false,
	dim_inactive = false,
	lualine_bold = false,

	on_colors = function(colors)
		-- colors.bg_float = "#002b36"
		colors.bg_sidebar = "#002b36"
		colors.hint = "#FA7334"
		colors.error = colors.red
		colors.warning = colors.yellow100
		colors.info = colors.cyan300
	end,

	on_highlights = function(highlights, colors) end,
})

vim.cmd([[colorscheme solarized-osaka]])
