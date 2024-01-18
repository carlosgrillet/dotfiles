local status, autotag = pcall(require, "nvim-ts-autotag")
if not status then
	vim.notify("Failed to load nvim-ts-autotag")
	return
end

autotag.setup({})
