local status, diffview = pcall(require, "diffview")
if not status then
	vim.notify("Failed to load diffview")
	return
end
local keymap = vim.keymap.set

diffview.setup()
keymap("n", ";d", ":DiffviewFileHistory<Return>", { silent = true })
keymap("n", ";c", ":DiffviewOpen<Return>", { silent = true })
keymap("n", ";q", ":tabclose<Return>", { silent = true })
