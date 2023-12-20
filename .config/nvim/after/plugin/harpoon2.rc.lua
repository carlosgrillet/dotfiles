local status, harpoon = pcall(require, "harpoon")
if (not status) then return end

harpoon:setup()

vim.keymap.set("n", "<leader>e", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end)
vim.keymap.set("n", "<leader>s", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>d", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>f", function() harpoon:list():select(3) end)
-- vim.keymap.set("n", "<leader>g", function() harpoon:list():select(4) end)
