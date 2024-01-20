local status, notify = pcall(require, "notify")
if not status then
	vim.notify("Failed to load notify")
	return
end

notify.setup({
	max_width = function()
		return vim.o.columns * 0.5
	end,
	max_height = function()
		return vim.o.lines * 0.3
	end,
	on_open = function(win)
		vim.api.nvim_win_set_config(win, { zindex = 100 })
	end,
	fps = 60,
	stages = "fade",
	timeout = 500,
	render = "wrapped-compact",
})
