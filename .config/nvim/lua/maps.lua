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
-- Resize window
keymap("n", "<C-w><left>", "<C-w><")
keymap("n", "<C-w><right>", "<C-w>>")
keymap("n", "<C-w><up>", "<C-w>+")
keymap("n", "<C-w><down>", "<C-w>-")
-- Move the selected lines
keymap("v", "J", ":m '>+1<CR>gv=gv")
keymap("v", "K", ":m '<-2<CR>gv=gv")
-- Keep the cursor in the center when searching
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")
-- Keep the cursor in the center when moving
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")
keymap("n", "}", "}zz")
keymap("n", "{", "{zz")
-- Keep curson in the cneter when jumping
keymap("n", "<C-o>", "<C-o>zz")
keymap("n", "`.", "`.zz")
-- Keep curson in the center at the end of the file
keymap("n", "G", "Gzz")
-- Stay cursor when join lines
keymap("n", "J", "mzJ`z")
-- Yank to the clipboard
keymap("n", "<Leader>y", '"+y')
keymap("v", "<Leader>y", '"+y')
keymap("n", "<Leader>Y", '"+Y')
-- Paste from clipboard
keymap("n", "<Leader>p", '"+gP')
-- Add vim motions on insert mode
keymap("i", "<C-h>", "<Esc>Bi")
keymap("i", "<C-j>", "<Esc>o")
keymap("i", "<C-k>", "<Esc>O")
keymap("i", "<C-l>", "<Esc>Wi")
-- Map scape for terminal mode
keymap("t", "<Esc><Esc>", "<C-\\><C-n>")
-- Return to start point on leave visual
keymap("x", "<Esc>", "<Esc>`V", { silent = true })
-- Make my life better in Go
keymap("n", "<leader>ee", "oif err != nil {<CR>}<Esc>Oreturn err<Esc>")
