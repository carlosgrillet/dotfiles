local keymap = vim.keymap.set

-- Delete without yank
keymap('n', 'x', '"_x')
-- Split window
keymap('n', 'ss', ':split<Return><C-w>w', { silent = true })
keymap('n', 'sv', ':vsplit<Return><C-w>w', { silent = true })
-- Move window
keymap('n', '<Space>', '<C-w>w')
keymap('', 'sh', '<C-w>h')
keymap('', 'sk', '<C-w>k')
keymap('', 'sj', '<C-w>j')
keymap('', 'sl', '<C-w>l')
keymap('n', '<C-d>', '<C-d>zz')
keymap('n', '<C-u>', '<C-u>zz')
-- Resize window
keymap('n', '<C-w><left>', '<C-w><')
keymap('n', '<C-w><right>', '<C-w>>')
keymap('n', '<C-w><up>', '<C-w>+')
keymap('n', '<C-w><down>', '<C-w>-')
-- Move the selected lines
keymap('v', 'J', ":m '>+1<CR>gv=gv")
keymap('v', 'K', ":m '<-2<CR>gv=gv")
-- Search in the middle of screen
keymap('n', 'n', 'nzzzv')
keymap('n', 'N', 'Nzzzv')
-- Stay cursor when join lines
keymap('n', 'J', 'mzJ`z') -- Keep curson in the middle when half-page jumping
keymap('n', '<C-d>', '<C-d>zz')
keymap('n', '<C-u>', '<C-u>zz')
-- Yank to the clipboard
keymap('n', '<Leader>y', '"+y')
keymap('v', '<Leader>y', '"+y')
keymap('n', '<Leader>Y', '"+Y')
-- Paste from clipboard
keymap('n', '<Leader>p', '"+gP')
-- Leave without saving
keymap('n', 'ZZ', '<Cmd>q!<CR>')
-- Paste from clipboard
keymap('n', '<Leader>p', '"+gP')
