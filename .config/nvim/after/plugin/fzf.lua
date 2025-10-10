local status, fzf_lua = pcall(require, "fzf-lua")
if not status then
	vim.notify("Failed to load fzf-lua")
	return
end

fzf_lua.setup {
  files = {
    cwd_prompt= false,
    git_icons = true,
  },
}

-- Keymaps
vim.keymap.set("n", ";F", function()
	fzf_lua.builtin()
end)

vim.keymap.set("n", ";f", function()
	fzf_lua.files()
end)

vim.keymap.set("n", ";g", function()
	fzf_lua.live_grep_native()
end)

vim.keymap.set("v", ";G", function()
	fzf_lua.grep_visual()
end)

vim.keymap.set("n", ";d", function()
	fzf_lua.diagnostics_document()
end)

vim.keymap.set("n", ";b", function()
	fzf_lua.buffers()
end)

vim.keymap.set("n", ";;", function()
  fzf_lua.resume()
end)
