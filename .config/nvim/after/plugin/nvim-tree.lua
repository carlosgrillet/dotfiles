local status, nvim_tree = pcall(require, "nvim-tree")
if not status then
	vim.notify("Failed to load nvim-tree")
	return
end

nvim_tree.setup({
	disable_netrw = false,
	hijack_netrw = true,
	open_on_tab = false,
	hijack_cursor = true,
	update_cwd = true,
	update_focused_file = {
		enable = true,
		update_cwd = true,
		ignore_list = {},
	},
	renderer = {
		root_folder_label = false,
	},
	view = {
		width = "30%",
		side = "right",
		number = true,
		relativenumber = true,
	},
	filters = {
		custom = {
			".git",
		},
	},
})

-- Map nvim-tree command
vim.keymap.set("n", "<Leader>t", ":NvimTreeToggle<CR>", { silent = true })
