local keymap = vim.keymap.set

-- Delete character without yank
keymap("n", "x", '"_x')
-- Split window
keymap("n", "ss", ":new<Return>", { silent = true })
keymap("n", "sv", ":vnew<Return>", { silent = true })
-- Move window
keymap("n", "<Space>", "<C-w>w")
keymap("", "sh", "<C-w>h")
keymap("", "sk", "<C-w>k")
keymap("", "sj", "<C-w>j")
keymap("", "sl", "<C-w>l")
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")
keymap("n", "}", "}zz")
keymap("n", "{", "{zz")
-- Resize window
keymap("n", "<C-w><left>", "<C-w><")
keymap("n", "<C-w><right>", "<C-w>>")
keymap("n", "<C-w><up>", "<C-w>+")
keymap("n", "<C-w><down>", "<C-w>-")
-- Move the selected lines
keymap("v", "J", ":m '>+1<CR>gv=gv")
keymap("v", "K", ":m '<-2<CR>gv=gv")
-- Search in the middle of screen
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")
-- Stay cursor when join lines
keymap("n", "J", "mzJ`z")
-- Keep curson in the middle when moving
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")
-- Keep curson in the middle when jumping
keymap("n", "<C-o>", "<C-o>zz")
keymap("n", "`.", "`.zz")
-- Keep curson in the middle at the end of the file
keymap("n", "G", "Gzz")
-- Yank to the clipboard
keymap("n", "<Leader>y", '"+y')
keymap("v", "<Leader>y", '"+y')
keymap("n", "<Leader>Y", '"+Y')
-- Paste from clipboard
keymap("n", "<Leader>p", '"+gP')
-- Delete word backward on insert
keymap("i", "<C-h>", "<Esc>diWgea")
-- Move to the end of the line on insert
keymap("i", "<C-l>", "<Esc>A")
-- Don't use scape to exit inset mode
keymap({ "i", "n" }, "<C-c>", "<Esc>")
--Insert new line in the middle of the line
keymap("i", "<C-j>", "<Esc>o")
