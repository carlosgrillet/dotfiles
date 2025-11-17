local map = vim.keymap.set

-- Delete character without yank
map("n", "x", '"_x')
-- Split window
map("n", "ss", ":new<Return>", { silent = true })
map("n", "sv", ":vnew<Return>", { silent = true })
-- Move window
map("n", "<Space>", "<C-w>w")
map("", "sh", "<C-w>h")
map("", "sk", "<C-w>k")
map("", "sj", "<C-w>j")
map("", "sl", "<C-w>l")
-- Resize window
map("n", "<C-w><left>", "<C-w><")
map("n", "<C-w><right>", "<C-w>>")
map("n", "<C-w><up>", "<C-w>+")
map("n", "<C-w><down>", "<C-w>-")
-- Move the selected lines
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")
-- Keep the cursor in the center when searching
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
-- Keep the cursor in the center when moving
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "}", "}zz")
map("n", "{", "{zz")
-- Keep curson in the cneter when jumping
map("n", "<C-o>", "<C-o>zz")
map("n", "`.", "`.zz")
-- Keep curson in the center at the end of the file
map("n", "G", "Gzz")
-- Stay cursor when join lines
map("n", "J", "mzJ`z")
-- Yank to the clipboard
map("n", "<Leader>y", '"+y')
map("v", "<Leader>y", '"+y')
map("n", "<Leader>Y", '"+Y')
-- Paste from clipboard
map("n", "<Leader>p", '"+gP')
-- Add vim motions on insert mode
map("i", "<C-h>", "<Esc>Bi")
map("i", "<C-j>", "<Esc>o")
map("i", "<C-k>", "<Esc>O")
map("i", "<C-l>", "<Esc>Wi")
-- Map scape for terminal mode
map("t", "<Esc>", "<C-\\><C-n>")
