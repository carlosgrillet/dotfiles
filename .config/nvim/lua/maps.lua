local keymap = vim.keymap

keymap.set('n', 'x', '"_x')

-- Increment/decrement
--keymap.set('n', '+', '<C-a>')
--keymap.set('n', '-', '<C-x>')

-- Select all
--keymap.set('n', '<C-a>', 'gg<S-v>G')
-- New tab
keymap.set('n', 'te', ':tabedit', { silent = true})
-- Split window
keymap.set('n', 'ss', ':split<Return><C-w>w', { silent = true })
keymap.set('n', 'sv', ':vsplit<Return><C-w>w', { silent = true })
-- Move window
keymap.set('n', '<Space>', '<C-w>w')
keymap.set('', 'sh', '<C-w>h')
keymap.set('', 'sk', '<C-w>k')
keymap.set('', 'sj', '<C-w>j')
keymap.set('', 'sl', '<C-w>l')
keymap.set('n', '<C-d>', '<C-d>zz')
keymap.set('n', '<C-u>', '<C-u>zz')
-- Resize window
keymap.set('n', '<C-w><left>', '<C-w><')
keymap.set('n', '<C-w><right>', '<C-w>>')
keymap.set('n', '<C-w><up>', '<C-w>+')
keymap.set('n', '<C-w><down>', '<C-w>-')
-- Move the selected lines
keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
keymap.set('v', 'K', ":m '<-2<CR>gv=gv")
-- Search in the middle of screen
keymap.set('n', 'n', 'nzzzv')
keymap.set('n', 'N', 'Nzzzv')
-- Stay cursor when join lines
keymap.set('n', 'J', 'mzJ`z')
-- Keep curson in the middle when half-page jumping
keymap.set('n', '<C-d>', '<C-d>zz')
keymap.set('n', '<C-u>', '<C-u>zz')
-- Yank to the clipboard
keymap.set('n', '<Leader>y', '"+y')
keymap.set('v', '<Leader>y', '"+y')
keymap.set('n', '<Leader>Y', '"+Y')
-- Paste from clipboard
keymap.set('n', '<Leader>p', '"+gP')
-- Leave without saving
keymap.set('n', 'ZZ', '<Cmd>q!<CR>')
