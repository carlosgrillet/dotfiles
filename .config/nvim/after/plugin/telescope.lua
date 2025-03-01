local status, telescope = pcall(require, "telescope")
if not status then
	vim.notify("Failed to load telescope")
	return
end
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

telescope.setup({
	defaults = {
		mappings = {
			n = {
				["q"] = actions.close,
			},
		},
	},
})

vim.keymap.set("n", ";f", function()
	builtin.find_files({
		hidden = true,
		file_ignore_patterns = {
			-- Files
			"%.a",
			"%.class",
			"%.mkv",
			"%.mp4",
			"%.o",
			"%.out",
			"%.pdf",
			"%.png",
			"%.jpg",
			"%.zip",
			"%.tar",
			"%.gz",
			-- Directories
			".cache/",
			".git/",
			".github/",
			".terraform/",
			".node_modules/",
		},
	})
end)
vim.keymap.set("n", ";r", function()
	builtin.live_grep() -- Ensure ripgrep binary is installed in your system
end)
vim.keymap.set("n", "\\\\", function()
	builtin.buffers({
		initial_mode = "normal",
	})
end)
vim.keymap.set("n", ";t", function()
	builtin.help_tags()
end)
vim.keymap.set("n", ";;", function()
	builtin.resume()
end)
vim.keymap.set("n", ";e", function()
	builtin.diagnostics()
end)
