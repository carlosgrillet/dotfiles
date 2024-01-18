local status, ts = pcall(require, "nvim-treesitter.configs")
if not status then
	vim.notify("Failed to load nvim-treesitter")
	return
end

ts.setup({
	highlight = {
		enable = true,
		disable = {},
	},
	indent = {
		enable = true,
		disable = {},
	},
	-- to avoid errors run sudo apt install g++
	ensure_installed = {
		"bash",
		"diff",
		"html",
		"javascript",
		"json",
		"json",
		"lua",
		"python",
		"tsx",
		"typescript",
		"yaml",
		"vimdoc",
	},
	autotag = {
		enable = true,
	},
})

--run TSUpdateSync when having problems with tree-sitter
